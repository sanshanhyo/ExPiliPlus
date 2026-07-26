import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/pages/webdav/webdav.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class WebDavSettingPage extends StatefulWidget {
  const WebDavSettingPage({
    super.key,
    this.showAppBar = true,
  });

  final bool showAppBar;

  @override
  State<WebDavSettingPage> createState() => _WebDavSettingPageState();
}

class _WebDavSettingPageState extends State<WebDavSettingPage> {
  final _uriCtr = TextEditingController(text: Pref.webdavUri);
  final _usernameCtr = TextEditingController(text: Pref.webdavUsername);
  final _passwordCtr = TextEditingController(text: Pref.webdavPassword);
  final _directoryCtr = TextEditingController(text: Pref.webdavDirectory);
  bool _obscureText = true;

  @override
  void dispose() {
    _uriCtr.dispose();
    _usernameCtr.dispose();
    _passwordCtr.dispose();
    _directoryCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final showAppBar = widget.showAppBar;
    final padding = MediaQuery.viewPaddingOf(context);
    return Scaffold(
      appBar: showAppBar ? AppBar(title: Text(l10n.webDavSettingsTitle)) : null,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          ListView(
            padding: padding.copyWith(
              top: 20,
              left: 20 + (showAppBar ? padding.left : 0),
              right: 20 + (showAppBar ? padding.right : 0),
              bottom: padding.bottom + 100,
            ),
            children: [
              TextField(
                controller: _uriCtr,
                decoration: InputDecoration(
                  labelText: l10n.onboardingWebDavAddress,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameCtr,
                decoration: InputDecoration(
                  labelText: l10n.onboardingWebDavUser,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordCtr,
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  labelText: l10n.onboardingWebDavPassword,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                    icon: _obscureText
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                obscureText: _obscureText,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _directoryCtr,
                decoration: InputDecoration(
                  labelText: l10n.onboardingWebDavPath,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: Style.mdRadius,
                        ),
                      ),
                      onPressed: WebDav().backup,
                      child: Text(l10n.webDavBackupSettings),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: Style.mdRadius,
                        ),
                      ),
                      onPressed: WebDav().restore,
                      child: Text(l10n.webDavRestoreSettings),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right:
                kFloatingActionButtonMargin + (showAppBar ? padding.right : 0),
            bottom: kFloatingActionButtonMargin + padding.bottom,
            child: FloatingActionButton(
              child: const Icon(Icons.save),
              onPressed: () async {
                await GStorage.setting.putAll({
                  SettingBoxKey.webdavUri: _uriCtr.text,
                  SettingBoxKey.webdavUsername: _usernameCtr.text,
                  SettingBoxKey.webdavPassword: _passwordCtr.text,
                  SettingBoxKey.webdavDirectory: _directoryCtr.text,
                });
                if (_uriCtr.text.isEmpty) {
                  return;
                }
                try {
                  final res = await WebDav().init();
                  if (res.first) {
                    SmartDialog.showToast(l10n.webDavConfigurationSucceeded);
                  } else {
                    SmartDialog.showToast(
                      l10n.webDavConfigurationFailed('${res.second}'),
                    );
                  }
                } catch (e) {
                  SmartDialog.showToast(
                    l10n.webDavConfigurationFailed(e.toString()),
                  );
                  return;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
