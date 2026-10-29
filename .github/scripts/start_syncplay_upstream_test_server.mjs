import { readFile, writeFile } from 'node:fs/promises';
import { execFileSync } from 'node:child_process';
import { createServer as createHttpsServer } from 'node:https';
import { connect as connectTcp } from 'node:net';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';

const serverRoot = process.env.SYNCPLAY_UPSTREAM_SERVER_ROOT;
const certificatePath = process.env.SYNCPLAY_TEST_TLS_CERT;
const privateKeyPath = process.env.SYNCPLAY_TEST_TLS_KEY;
const portFile = process.env.SYNCPLAY_TEST_SERVER_PORT_FILE;
const expectedRevision = process.env.SYNCPLAY_UPSTREAM_REVISION;

for (const [name, value] of Object.entries({
  SYNCPLAY_UPSTREAM_SERVER_ROOT: serverRoot,
  SYNCPLAY_TEST_TLS_CERT: certificatePath,
  SYNCPLAY_TEST_TLS_KEY: privateKeyPath,
  SYNCPLAY_TEST_SERVER_PORT_FILE: portFile,
  SYNCPLAY_UPSTREAM_REVISION: expectedRevision,
})) {
  if (!value) throw new Error(`${name} must be set for the loopback test server.`);
}

const actualRevision = execFileSync(
  'git',
  ['-C', resolve(serverRoot, '..'), 'rev-parse', 'HEAD'],
  { encoding: 'utf8' },
).trim();
if (actualRevision !== expectedRevision) {
  throw new Error(
    `Expected pinned SyncPlay server ${expectedRevision}, got ${actualRevision}.`,
  );
}

const { createSyncServer, getDefaultPersistenceConfig, getDefaultSecurityConfig } =
  await import(pathToFileURL(resolve(serverRoot, 'dist/app.js')).href);

const tls = {
  cert: await readFile(certificatePath),
  key: await readFile(privateKeyPath),
};
const openProxySockets = new Set();
let upstream;
let backendPort;
let stopping;

const proxy = createHttpsServer(tls);
proxy.on('connection', (socket) => {
  openProxySockets.add(socket);
  socket.once('close', () => openProxySockets.delete(socket));
});
proxy.on('upgrade', (request, clientSocket, head) => {
  if (backendPort == null) {
    clientSocket.destroy();
    return;
  }

  const backendSocket = connectTcp(backendPort, '127.0.0.1');
  openProxySockets.add(clientSocket);
  openProxySockets.add(backendSocket);
  clientSocket.once('close', () => openProxySockets.delete(clientSocket));
  backendSocket.once('close', () => openProxySockets.delete(backendSocket));

  backendSocket.once('connect', () => {
    const requestLines = [
      `${request.method ?? 'GET'} ${request.url ?? '/'} HTTP/${request.httpVersion}`,
    ];
    for (let index = 0; index < request.rawHeaders.length; index += 2) {
      requestLines.push(`${request.rawHeaders[index]}: ${request.rawHeaders[index + 1]}`);
    }
    backendSocket.write(`${requestLines.join('\r\n')}\r\n\r\n`);
    if (head.length > 0) backendSocket.write(head);
    clientSocket.pipe(backendSocket);
    backendSocket.pipe(clientSocket);
  });

  backendSocket.on('error', () => clientSocket.destroy());
  clientSocket.on('error', () => backendSocket.destroy());
});

async function listen(server, port = 0) {
  await new Promise((resolveListen, rejectListen) => {
    server.once('error', rejectListen);
    server.listen(port, '127.0.0.1', resolveListen);
  });
  const address = server.address();
  if (!address || typeof address === 'string') {
    throw new Error('Loopback listener did not expose a TCP port.');
  }
  return address.port;
}

async function start() {
  const tlsPort = await listen(proxy);
  const allowedOrigin = `https://127.0.0.1:${tlsPort}`;
  upstream = await createSyncServer(
    {
      ...getDefaultSecurityConfig(),
      allowedOrigins: [allowedOrigin],
    },
    {
      ...getDefaultPersistenceConfig(),
      instanceId: 'expiliplus-dart-integration-test',
    },
    {
      logEvent: () => {},
      serviceVersion: 'expiliplus-dart-integration-test',
      adminUiConfig: { enabled: false },
    },
  );
  backendPort = await listen(upstream.httpServer);
  await writeFile(portFile, `${tlsPort}\n`, { mode: 0o600 });
  console.log(
    `SYNCPLAY_TEST_SERVER_READY revision=${actualRevision} origin=${allowedOrigin} upstream=127.0.0.1:${backendPort}`,
  );
}

async function stop() {
  if (stopping) return stopping;
  stopping = (async () => {
    for (const socket of openProxySockets) socket.destroy();
    if (proxy.listening) {
      await new Promise((resolveClose) => proxy.close(resolveClose));
    }
    if (upstream) {
      const failures = await upstream.close();
      if (failures.length > 0) {
        console.error('SyncPlay test server shutdown reported failures:', failures);
        process.exitCode = 1;
      }
    }
  })();
  return stopping;
}

process.once('SIGTERM', () => {
  void stop().finally(() => process.exit());
});
process.once('SIGINT', () => {
  void stop().finally(() => process.exit());
});

try {
  await start();
} catch (error) {
  console.error(error);
  await stop();
  process.exitCode = 1;
}
