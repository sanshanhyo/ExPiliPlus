#!/usr/bin/env python3
"""Apply the shared GIF completion fix to the pinned benchmark baseline."""

from __future__ import annotations

import argparse
import hashlib
import subprocess
from pathlib import Path


CORRECTNESS_BASELINE_SHA = "abbfdd170c30a3996f083a00b3cf49a548b407a5"
EXPECTED_SOURCE_SHA256 = "d2e4280de9ba3201ac8fcb4f95025e174d3fd3dfb4ebc58f3d74705abc0d289a"
CONVERTER_RELATIVE_PATH = Path(
    "lib/plugin/pl_player/widgets/mpv_convert_gif.dart"
)

END_FILE_START = "      case generated.mpv_event_id.MPV_EVENT_END_FILE:\n"
SHUTDOWN_START = "      case generated.mpv_event_id.MPV_EVENT_SHUTDOWN:\n"

DEFERRED_END_FILE_CASE = """      case generated.mpv_event_id.MPV_EVENT_END_FILE:
        final end = event.ref.data.cast<generated.mpv_event_end_file>().ref;
        if (_endFileFinishScheduled) break;
        _endFileFinishScheduled = true;
        final reason = end.reason;
        final error = end.error;
        final errorText = error == 0
            ? ''
            : _sanitizeDiagnostic(_errorText(error));
        debugPrint(
          'GifConvert: end-file completion deferred '
          'reason=$reason error=$error',
        );
        // Let the native event callback return before closing the muxer.
        Timer.run(() => _finishAfterEndFile(reason, error, errorText));
        break;
"""

DEFERRED_FINISH_HELPER = """  void _finishAfterEndFile(int reason, int error, String errorText) {
    if (_disposed || _completer.isCompleted) return;
    _disposed = true;

    try {
      _disposeNative();
      final reachedEof =
          reason == generated.mpv_end_file_reason.MPV_END_FILE_REASON_EOF;
      final output = File(outFile);
      final exists = output.existsSync();
      final size = exists ? output.lengthSync() : 0;
      var validation = exists ? _validateOutput(output) : null;
      if (validation != null &&
          validation.frameCount >= 2 &&
          !validation.hasInfiniteLoop) {
        _ensureInfiniteLoop(output);
        validation = _validateOutput(output);
      }
      final success =
          reachedEof &&
          error == 0 &&
          _lastError == null &&
          exists &&
          size > 0 &&
          validation?.isValid == true;
      debugPrint(
        'GifConvert: deferred completion after native teardown '
        'reason=$reason eof=$reachedEof error=$error '
        '${errorText.isEmpty ? '' : '($errorText)'} '
        'loaded=$_loaded output=$exists bytes=$size '
        'frames=${validation?.frameCount ?? 0} '
        'loop=${validation?.hasInfiniteLoop ?? false} '
        'lastError=$_lastError success=$success',
      );

      _succeeded = success;
      progress?.value = 1;
      if (!success) _removeOutputIfPresent();
      if (!_completer.isCompleted) _completer.complete(success);
    } catch (error) {
      _recordError('GIF validation after native teardown failed: $error');
      _succeeded = false;
      _removeOutputIfPresent();
      if (!_completer.isCompleted) _completer.complete(false);
    }
  }

"""


def apply_common_lifecycle_fix(source: str) -> str:
    """Make only the shared speed and post-callback teardown changes."""
    if "'speed': '1'," in source or "_endFileFinishScheduled" in source:
        raise ValueError("The common lifecycle fix is already present")
    if source.count("'end': (start + duration).toStringAsFixed(3),") != 1:
        raise ValueError("Expected exactly one mpv end option")
    if source.count(END_FILE_START) != 1 or source.count(SHUTDOWN_START) != 1:
        raise ValueError("Could not uniquely locate the mpv END_FILE handler")
    if source.count("  void _complete(bool success) {") != 1:
        raise ValueError("Could not uniquely locate GIF completion helpers")

    source = source.replace(
        "'end': (start + duration).toStringAsFixed(3),",
        "'end': (start + duration).toStringAsFixed(3),\n        'speed': '1',",
        1,
    )
    source = source.replace(
        "  bool _succeeded = false;\n",
        "  bool _succeeded = false;\n  bool _endFileFinishScheduled = false;\n",
        1,
    )

    start = source.index(END_FILE_START)
    end = source.index(SHUTDOWN_START, start)
    source = source[:start] + DEFERRED_END_FILE_CASE + source[end:]
    source = source.replace(
        "  void _complete(bool success) {\n",
        DEFERRED_FINISH_HELPER + "  void _complete(bool success) {\n",
        1,
    )

    if source.count("Timer.run(() => _finishAfterEndFile(reason, error, errorText));") != 1:
        raise ValueError("Deferred END_FILE completion was not installed")
    if source.count("_command(['vf', 'set', _videoFilters])") != 2:
        raise ValueError("The baseline's post-FILE_LOADED filter check was altered")
    return source


def apply_to_worktree(worktree: Path, source_sha: str) -> str:
    if source_sha != CORRECTNESS_BASELINE_SHA:
        raise ValueError(
            f"Correctness patch is pinned to {CORRECTNESS_BASELINE_SHA}, not {source_sha}"
        )
    current_sha = subprocess.run(
        ["git", "-C", str(worktree), "rev-parse", "HEAD"],
        check=True,
        capture_output=True,
        text=True,
    ).stdout.strip()
    if current_sha != CORRECTNESS_BASELINE_SHA:
        raise ValueError(f"Unexpected baseline worktree HEAD: {current_sha}")

    path = worktree / CONVERTER_RELATIVE_PATH
    original = path.read_bytes()
    original_sha = hashlib.sha256(original).hexdigest()
    if original_sha != EXPECTED_SOURCE_SHA256:
        raise ValueError(
            "Pinned baseline converter source changed: "
            f"expected {EXPECTED_SOURCE_SHA256}, found {original_sha}"
        )
    patched = apply_common_lifecycle_fix(original.decode("utf-8"))
    encoded = patched.encode("utf-8")
    path.write_bytes(encoded)
    return hashlib.sha256(encoded).hexdigest()


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("worktree", type=Path)
    parser.add_argument("source_sha")
    parser.add_argument("--metadata-output", type=Path, required=True)
    args = parser.parse_args()

    try:
        patched_sha = apply_to_worktree(args.worktree, args.source_sha)
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        parser.error(str(error))

    script_sha = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    args.metadata_output.write_text(
        "\n".join(
            (
                f"baseline_commit={CORRECTNESS_BASELINE_SHA}",
                "shared_correctness_fix=mpv-speed-1-and-deferred-end-file-teardown",
                f"input_converter_sha256={EXPECTED_SOURCE_SHA256}",
                f"patched_converter_sha256={patched_sha}",
                f"patch_script_sha256={script_sha}",
                "retained_difference=FILE_LOADED filter reapplication stays in baseline",
                "",
            )
        ),
        encoding="utf-8",
    )
    print(args.metadata_output.read_text(encoding="utf-8"), end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
