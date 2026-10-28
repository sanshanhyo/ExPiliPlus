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

  Future<int?> _requestMid() async {
    final l10n = context.l10n;
    final controller = TextEditingController();
    var invalid = false;
    try {
      return await showDialog<int>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: Text(l10n.commentPlusOneAddUploader),
            content: TextField(
              controller: controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: l10n.commentPlusOneUploaderUid,
                hintText: l10n.commentPlusOneEnterUploaderUid,
                errorText: invalid ? l10n.commentPlusOneInvalidUid : null,
              ),
              onChanged: (_) {
                if (invalid) setDialogState(() => invalid = false);
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.commonCancel),
              ),
              FilledButton(
                onPressed: () {
                  final mid = int.tryParse(controller.text);
                  if (mid == null || mid <= 0) {
                    setDialogState(() => invalid = true);
                    return;
                  }
                  Navigator.of(context).pop(mid);
                },
                child: Text(l10n.commonConfirm),
              ),
            ],
          ),
        ),
      );
    } finally {
      controller.dispose();
    }
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
