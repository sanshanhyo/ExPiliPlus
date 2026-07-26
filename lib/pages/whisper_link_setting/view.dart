import 'package:ex_piliplus/common/widgets/pendant_avatar.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models_new/msg/im_user_infos/datum.dart';
import 'package:ex_piliplus/models_new/msg/msg_dnd/uid_setting.dart';
import 'package:ex_piliplus/models_new/msg/session_ss/data.dart';
import 'package:ex_piliplus/pages/whisper_link_setting/controller.dart';
import 'package:ex_piliplus/utils/extension/theme_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WhisperLinkSettingPage extends StatefulWidget {
  const WhisperLinkSettingPage({
    super.key,
    required this.talkerUid,
  });

  final int talkerUid;

  @override
  State<WhisperLinkSettingPage> createState() => _WhisperLinkSettingPageState();
}

class _WhisperLinkSettingPageState extends State<WhisperLinkSettingPage> {
  late final WhisperLinkSettingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      WhisperLinkSettingController(talkerUid: widget.talkerUid),
      tag: Utils.generateRandomString(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final divider = Divider(
      height: 12,
      thickness: 12,
      color: theme.colorScheme.outline.withValues(alpha: 0.1),
    );
    final divider2 = Divider(
      height: 1,
      indent: 16,
      color: theme.colorScheme.outline.withValues(alpha: 0.1),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(context.l10n.messagesChatSettings)),
      body: ListView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewPaddingOf(context).bottom + 100,
        ),
        children: [
          divider,
          Obx(
            () => _buildUserInfo(theme, divider, _controller.userState.value),
          ),
          Obx(
            () => _buildSessionSs(
              theme,
              divider,
              divider2,
              _controller.sessionSs.value,
            ),
          ),
          Obx(
            () {
              if (_controller.sessionSs.value case Success(:final response)) {
                return _buildBlockItem(response.followStatus == 128);
              }
              return const SizedBox.shrink();
            },
          ),
          divider2,
          ListTile(
            dense: true,
            onTap: _controller.report,
            title: Text(
              context.l10n.commonReport,
              style: const TextStyle(fontSize: 14),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: theme.colorScheme.outline,
            ),
          ),
          divider,
        ],
      ),
    );
  }

  Widget _buildBlockItem(bool isBlocked) {
    return ListTile(
      dense: true,
      onTap: () => _controller.setBlock(isBlocked),
      title: Text(
        context.l10n.messagesAddToBlocked,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: Transform.scale(
        alignment: Alignment.centerRight,
        scale: 0.8,
        child: Switch(
          value: isBlocked,
          onChanged: (value) => _controller.setBlock(isBlocked),
        ),
      ),
    );
  }

  Widget _buildUserInfo(
    ThemeData theme,
    Widget divider,
    LoadingState<List<ImUserInfosData>?> loadingState,
  ) {
    return switch (loadingState) {
      Loading() => const SizedBox.shrink(),
      Success(:final response) =>
        response != null && response.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) {
                      final ImUserInfosData item = response.first;
                      return ListTile(
                        onTap: () => Get.toNamed('/member?mid=${item.mid}'),
                        leading: PendantAvatar(
                          item.face,
                          size: 42,
                          badgeSize: 14,
                          vipStatus: item.vip?.status,
                          pendantImage: item.pendant?.image,
                          officialType: item.official?.type,
                        ),
                        title: Text(
                          item.name!,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                item.vip?.status != null &&
                                    item.vip!.status > 0 &&
                                    item.vip?.type == 2
                                ? theme.colorScheme.vipColor
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          'UID: ${item.mid}${item.sign?.isNotEmpty == true ? '\n${item.sign}' : ''}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        trailing: Icon(
                          size: 22,
                          Icons.keyboard_arrow_right,
                          color: theme.colorScheme.outline,
                        ),
                      );
                    },
                  ),
                  divider,
                ],
              )
            : const SizedBox.shrink(),
      Error(:final errMsg) => _errWidget(errMsg, _controller.getUserInfo),
    };
  }

  Widget _buildSessionSs(
    ThemeData theme,
    Widget divider,
    Widget divider2,
    LoadingState<SessionSsData> loadingState,
  ) {
    return switch (loadingState) {
      Loading() => const SizedBox.shrink(),
      Success(:final response) => Builder(
        builder: (context) {
          late final subTitleS = TextStyle(
            fontSize: 13,
            color: theme.colorScheme.outline,
          );
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (response.showPushSetting == 1)
                ListTile(
                  dense: true,
                  onTap: () => _controller.setPush(response.pushSetting == 0),
                  title: Text(
                    context.l10n.messagesReceivePush,
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    context.l10n.messagesPushDescription,
                    style: subTitleS,
                  ),
                  trailing: Transform.scale(
                    alignment: Alignment.centerRight,
                    scale: 0.8,
                    child: Switch(
                      value: response.pushSetting == 0,
                      onChanged: (value) =>
                          _controller.setPush(response.pushSetting == 0),
                    ),
                  ),
                ),
              divider2,
              Obx(
                () => ListTile(
                  dense: true,
                  onTap: _controller.setPin,
                  title: Text(
                    context.l10n.messagesPinChat,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Transform.scale(
                    alignment: Alignment.centerRight,
                    scale: 0.8,
                    child: Switch(
                      value: _controller.isPinned.value,
                      onChanged: (value) => _controller.setPin(),
                    ),
                  ),
                ),
              ),
              divider2,
              Obx(() => _buildMuteItem(_controller.msgDnd.value)),
              divider,
            ],
          );
        },
      ),
      Error(:final errMsg) => _errWidget(errMsg, _controller.getSessionSs),
    };
  }

  Widget _buildMuteItem(LoadingState<List<UidSetting>?> loadingState) {
    return switch (loadingState) {
      Loading() => const SizedBox.shrink(),
      Success(:final response) =>
        response != null && response.isNotEmpty
            ? ListTile(
                dense: true,
                onTap: () => _controller.setMute(response.first.setting == 1),
                title: Text(
                  context.l10n.messagesMute,
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: Transform.scale(
                  alignment: Alignment.centerRight,
                  scale: 0.8,
                  child: Switch(
                    value: response.first.setting == 1,
                    onChanged: (value) =>
                        _controller.setMute(response.first.setting == 1),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      Error(:final errMsg) => _errWidget(errMsg, _controller.getMsgDnd),
    };
  }

  Widget _errWidget(String? errMsg, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          errMsg ?? '',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
