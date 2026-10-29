import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

class CommentPlusOneUploaderListPage extends StatefulWidget {
  const CommentPlusOneUploaderListPage({super.key});

  @override
  State<CommentPlusOneUploaderListPage> createState() =>
      _CommentPlusOneUploaderListPageState();
}

class _CommentPlusOneUploaderListPageState
    extends State<CommentPlusOneUploaderListPage> {
  late List<int> _mids;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _mids = Pref.commentPlusOneUpMids.toList()..sort();
  }

  Future<int?> _requestMid() {
    final l10n = context.l10n;
    return showDialog<int>(
      context: context,
      builder: (_) => _AddCommentPlusOneUploaderDialog(
        title: l10n.commentPlusOneAddUploader,
        uidLabel: l10n.commentPlusOneUploaderUid,
        hint: l10n.commentPlusOneEnterUploaderUid,
        invalidUid: l10n.commentPlusOneInvalidUid,
        cancelLabel: l10n.commonCancel,
        confirmLabel: l10n.commonConfirm,
      ),
    );
  }

  Future<void> _add() async {
    final mid = await _requestMid();
    if (mid == null || !mounted) return;
    final l10n = context.l10n;
    if (_mids.contains(mid)) {
      SmartDialog.showToast(l10n.commentPlusOneUploaderAlreadySelected);
      return;
    }
    final updated = {..._mids, mid};
    await Pref.setCommentPlusOneUpMids(updated);
    if (mounted) setState(_reload);
  }

  Future<void> _remove(int mid) async {
    final l10n = context.l10n;
    final confirmed = await showConfirmDialog(
      context: context,
      title: Text(l10n.commentPlusOneRemoveUploaderConfirm(mid.toString())),
    );
    if (!confirmed) return;
    final updated = {..._mids}..remove(mid);
    await Pref.setCommentPlusOneUpMids(updated);
    if (mounted) setState(_reload);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.commentPlusOneUploaderListTitle),
        actions: [
          IconButton(
            onPressed: _add,
            tooltip: l10n.commentPlusOneAddUploader,
            icon: const Icon(Icons.person_add_alt_1),
          ),
        ],
      ),
      body: _mids.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  l10n.commentPlusOneUploaderListEmpty,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: theme.colorScheme.outline),
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewPaddingOf(context).bottom + 32,
              ),
              itemCount: _mids.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final mid = _mids[index];
                return ListTile(
                  onTap: () => Get.toNamed('/member?mid=$mid'),
                  leading: const CircleAvatar(
                    child: Icon(Icons.person_outline),
                  ),
                  title: Text(mid.toString()),
                  subtitle: Text(l10n.commentPlusOneUploaderUid),
                  trailing: TextButton(
                    onPressed: () => _remove(mid),
                    child: Text(l10n.commonRemove),
                  ),
                );
              },
            ),
    );
  }
}

class _AddCommentPlusOneUploaderDialog extends StatefulWidget {
  const _AddCommentPlusOneUploaderDialog({
    required this.title,
    required this.uidLabel,
    required this.hint,
    required this.invalidUid,
    required this.cancelLabel,
    required this.confirmLabel,
  });

  final String title;
  final String uidLabel;
  final String hint;
  final String invalidUid;
  final String cancelLabel;
  final String confirmLabel;

  @override
  State<_AddCommentPlusOneUploaderDialog> createState() =>
      _AddCommentPlusOneUploaderDialogState();
}

class _AddCommentPlusOneUploaderDialogState
    extends State<_AddCommentPlusOneUploaderDialog> {
  late final TextEditingController _controller;
  bool _invalid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: _controller,
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: widget.uidLabel,
        hintText: widget.hint,
        errorText: _invalid ? widget.invalidUid : null,
      ),
      onChanged: (_) {
        if (_invalid) setState(() => _invalid = false);
      },
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(widget.cancelLabel),
      ),
      FilledButton(
        onPressed: () {
          final mid = int.tryParse(_controller.text);
          if (mid == null || mid <= 0) {
            setState(() => _invalid = true);
            return;
          }
          Navigator.of(context).pop(mid);
        },
        child: Text(widget.confirmLabel),
      ),
    ],
  );
}
