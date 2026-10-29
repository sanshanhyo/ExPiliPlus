import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show ReplyInfo;
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:material_ui/material_ui.dart';

class CommentPlusOneButton extends StatefulWidget {
  const CommentPlusOneButton({
    super.key,
    required this.replyItem,
    required this.onPressed,
    required this.isSupported,
  });

  final ReplyInfo replyItem;
  final Future<void> Function(ReplyInfo replyItem) onPressed;
  final bool isSupported;

  @override
  State<CommentPlusOneButton> createState() => _CommentPlusOneButtonState();
}

class _CommentPlusOneButtonState extends State<CommentPlusOneButton> {
  bool _isSending = false;

  Future<void> _send() async {
    if (_isSending || !widget.isSupported) return;
    setState(() => _isSending = true);
    try {
      await widget.onPressed(widget.replyItem);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Tooltip(
        message: widget.isSupported
            ? context.l10n.commentPlusOneTooltip
            : context.l10n.commentPlusOneUnsupported,
        child: TextButton(
          onPressed: _isSending || !widget.isSupported ? null : _send,
          style: TextButton.styleFrom(
            foregroundColor: widget.isSupported
                ? colorScheme.onPrimaryContainer
                : colorScheme.outline,
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: const Size(0, 32),
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: const StadiumBorder(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 3,
            children: [
              if (_isSending)
                const SizedBox.square(
                  dimension: 14,
                  child: CircularProgressIndicator(strokeWidth: 1.8),
                )
              else
                const Icon(Icons.add_reaction_outlined, size: 16),
              const Text(
                '+1',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
