import { readFile, writeFile } from 'node:fs/promises';
import { execFileSync } from 'node:child_process';
import { createRequire } from 'node:module';
import { createServer as createHttpsServer } from 'node:https';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';

const serverRoot = process.env.SYNCPLAY_UPSTREAM_SERVER_ROOT;
const portFile = process.env.SYNCPLAY_TEST_SERVER_PORT_FILE;
const tlsPortFile = process.env.SYNCPLAY_TEST_TLS_PORT_FILE;
const tlsKeyFile = process.env.SYNCPLAY_TEST_TLS_KEY_FILE;
const tlsCertFile = process.env.SYNCPLAY_TEST_TLS_CERT_FILE;
const expectedRevision = process.env.SYNCPLAY_UPSTREAM_REVISION;
const allowedOrigin = 'https://syncplay-integration.test';

for (const [name, value] of Object.entries({
  SYNCPLAY_UPSTREAM_SERVER_ROOT: serverRoot,
  SYNCPLAY_TEST_SERVER_PORT_FILE: portFile,
  SYNCPLAY_TEST_TLS_PORT_FILE: tlsPortFile,
  SYNCPLAY_TEST_TLS_KEY_FILE: tlsKeyFile,
  SYNCPLAY_TEST_TLS_CERT_FILE: tlsCertFile,
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

const {
  createSyncServer,
  getDefaultPersistenceConfig,
  getDefaultSecurityConfig,
} = await import(pathToFileURL(resolve(serverRoot, 'dist/app.js')).href);

const upstream = await createSyncServer(
  {
    ...getDefaultSecurityConfig(),
    allowedOrigins: [allowedOrigin],
  },
  {
    ...getDefaultPersistenceConfig(),
    instanceId: 'expiliplus-dart-integration-test',
  },
  {
    logEvent: (event, metadata = {}) => {
      if (
        event === 'room_event_consumed' ||
        event === 'room_event_consume_failed' ||
        event === 'room_event_publish_failed' ||
        event === 'video_share_deduplicated'
      ) {
        // Deliberately omit room codes, member/session identifiers and tokens.
        console.log(
          `SYNCPLAY_EVENT ${event} type=${metadata.eventType ?? ''} result=${metadata.result ?? ''} reason=${metadata.reason ?? ''} error=${metadata.error ?? ''}`,
        );
      }
    },
    serviceVersion: 'expiliplus-dart-integration-test',
    adminUiConfig: { enabled: false },
  },
);

const requireFromServer = createRequire(resolve(serverRoot, 'package.json'));
const { WebSocket, WebSocketServer } = requireFromServer('ws');
let tlsServer;
let tlsWebSocketServer;
let upstreamPort;
let stopping;
async function stop() {
  if (stopping) return stopping;
  stopping = (async () => {
    if (tlsWebSocketServer) {
      for (const socket of tlsWebSocketServer.clients) {
        socket.terminate();
      }
      await new Promise((resolveClose) => tlsWebSocketServer.close(resolveClose));
    }
    if (tlsServer?.listening) {
      await new Promise((resolveClose, rejectClose) => {
        tlsServer.close((error) => error ? rejectClose(error) : resolveClose());
      });
    }
    const failures = await upstream.close();
    if (failures.length > 0) {
      console.error('SyncPlay test server shutdown reported failures:', failures);
      process.exitCode = 1;
    }
  })();
  return stopping;
}

process.once('SIGTERM', () => void stop().finally(() => process.exit()));
process.once('SIGINT', () => void stop().finally(() => process.exit()));

try {
  await new Promise((resolveListen, rejectListen) => {
    upstream.httpServer.once('error', rejectListen);
    upstream.httpServer.listen(0, '127.0.0.1', resolveListen);
  });
  const address = upstream.httpServer.address();
  if (!address || typeof address === 'string') {
    throw new Error('Loopback listener did not expose a TCP port.');
  }
  upstreamPort = address.port;
  await writeFile(portFile, `${address.port}\n`, { mode: 0o600 });

  const [key, cert] = await Promise.all([
    readFile(tlsKeyFile),
    readFile(tlsCertFile),
  ]);
  tlsServer = createHttpsServer({ key, cert });
  tlsWebSocketServer = new WebSocketServer({ noServer: true });
  tlsServer.on('upgrade', (request, socket, head) => {
    if (request.url !== '/' || request.headers.origin !== allowedOrigin) {
      socket.end('HTTP/1.1 403 Forbidden\r\nConnection: close\r\n\r\n');
      return;
    }
    tlsWebSocketServer.handleUpgrade(request, socket, head, (client) => {
      const upstreamClient = new WebSocket(
        `ws://127.0.0.1:${upstreamPort}${request.url ?? '/'}`,
        { headers: { Origin: allowedOrigin } },
      );
      client.on('message', (data, isBinary) => {
        if (upstreamClient.readyState === WebSocket.OPEN) {
          upstreamClient.send(data, { binary: isBinary });
        }
      });
      upstreamClient.on('message', (data, isBinary) => {
        if (client.readyState === WebSocket.OPEN) {
          client.send(data, { binary: isBinary });
        }
      });
      const closePeer = (peer) => {
        if (
          peer.readyState === WebSocket.OPEN ||
          peer.readyState === WebSocket.CONNECTING
        ) {
          peer.close(1000, 'test proxy peer closed');
        }
      };
      client.on('close', () => closePeer(upstreamClient));
      upstreamClient.on('close', (code, reason) => {
        if (client.readyState === WebSocket.OPEN) client.close(code, reason);
      });
      client.on('error', () => upstreamClient.terminate());
      upstreamClient.on('error', () => client.terminate());
    });
  });
  await new Promise((resolveListen, rejectListen) => {
    tlsServer.once('error', rejectListen);
    tlsServer.listen(0, '127.0.0.1', resolveListen);
  });
  const tlsAddress = tlsServer.address();
  if (!tlsAddress || typeof tlsAddress === 'string') {
    throw new Error('Loopback TLS listener did not expose a TCP port.');
  }
  await writeFile(tlsPortFile, `${tlsAddress.port}\n`, { mode: 0o600 });
  console.log(
    `SYNCPLAY_TEST_SERVER_READY revision=${actualRevision} origin=${allowedOrigin} transport=loopback-ws port=${address.port} tls=loopback-wss tlsPort=${tlsAddress.port}`,
  );
} catch (error) {
  console.error(error);
  await stop();
  process.exitCode = 1;
}
