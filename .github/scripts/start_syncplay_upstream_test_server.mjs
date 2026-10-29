import { writeFile } from 'node:fs/promises';
import { execFileSync } from 'node:child_process';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';

const serverRoot = process.env.SYNCPLAY_UPSTREAM_SERVER_ROOT;
const portFile = process.env.SYNCPLAY_TEST_SERVER_PORT_FILE;
const expectedRevision = process.env.SYNCPLAY_UPSTREAM_REVISION;
const allowedOrigin = 'https://syncplay-integration.test';

for (const [name, value] of Object.entries({
  SYNCPLAY_UPSTREAM_SERVER_ROOT: serverRoot,
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

let stopping;
async function stop() {
  if (stopping) return stopping;
  stopping = (async () => {
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
  await writeFile(portFile, `${address.port}\n`, { mode: 0o600 });
  console.log(
    `SYNCPLAY_TEST_SERVER_READY revision=${actualRevision} origin=${allowedOrigin} transport=loopback-ws port=${address.port}`,
  );
} catch (error) {
  console.error(error);
  await stop();
  process.exitCode = 1;
}
