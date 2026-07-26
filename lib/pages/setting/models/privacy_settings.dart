import 'package:ex_piliplus/models/common/account_type.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/accounts/api_type.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

List<SettingsModel> privacySettings(BuildContext context) => [
  NormalModel(
    onTap: (context, setState) {
      if (!Accounts.main.isLogin) {
        SmartDialog.showToast(context.l10n.settingsSignInRequired);
        return;
      }
      Get.toNamed('/blackListPage');
    },
    title: context.l10n.settingsBlockedUsersManagement,
    subtitle: context.l10n.settingsBlockedUsersDescription,
    leading: const Icon(Icons.block),
  ),
  NormalModel(
    onTap: (context, setState) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.l10n.settingsAccountModeDetails),
          content: SingleChildScrollView(child: _getAccountDetail(context)),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: Text(context.l10n.commonConfirm),
            ),
          ],
        ),
      );
    },
    leading: const Icon(Icons.flag_outlined),
    title: context.l10n.settingsLearnAccountModes,
    subtitle: context.l10n.settingsAccountModesApiDescription,
  ),
];

Widget _getAccountDetail(BuildContext context) {
  final children = <Widget>[];
  final theme = TextTheme.of(context);
  for (final i in AccountType.values) {
    final url = ApiType.apiTypeSet[i];
    if (url == null) continue;

    children
      ..add(
        Center(
          child: Text(
            i.localizedTitle(context.l10n),
            style: theme.titleMedium,
          ),
        ),
      )
      ..add(Text(url.join('\n')));
  }
  return SelectionArea(
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      spacing: 8,
      children: children,
    ),
  );
}
