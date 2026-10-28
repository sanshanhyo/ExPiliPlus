import 'dart:io' show Platform;

import 'package:ex_piliplus/common/widgets/view_safe_area.dart';
import 'package:ex_piliplus/utils/aicu_url_policy.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:material_ui/material_ui.dart';

typedef AicuContentBuilder = Widget Function(BuildContext context, Uri uri);

class AicuLookupPage extends StatefulWidget {
  const AicuLookupPage({
    super.key,
    required this.initialUri,
    @visibleForTesting this.contentBuilder,
  });

  final Uri initialUri;
  @visibleForTesting
  final AicuContentBuilder? contentBuilder;

  @override
  State<AicuLookupPage> createState() => _AicuLookupPageState();
}

class _AicuLookupPageState extends State<AicuLookupPage> {
  InAppWebViewController? _controller;
  Uri? _currentUri;
  double _progress = 0;
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();
    _currentUri = widget.initialUri;
  }

  void _showBlockedNavigation(Uri? uri) {
    if (uri == null || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.aicuExternalLinkBlocked),
        action: SnackBarAction(
          label: context.l10n.aicuOpenExternal,
          onPressed: () {
            if (uri.scheme == 'https' && uri.userInfo.isEmpty) {
              PageUtils.launchURL(uri.toString());
            }
          },
        ),
      ),
    );
  }

  Future<void> _openCurrentPageExternally() async {
    final uri = _currentUri;
    if (uri != null && AicuUrlPolicy.isAllowedTopLevel(uri)) {
      await PageUtils.launchURL(uri.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final validInitialUri = AicuUrlPolicy.isAllowedTopLevel(
      widget.initialUri,
    );
    final body = !validInitialUri
        ? _MessagePanel(message: l10n.aicuInvalidTarget)
        : widget.contentBuilder != null
        ? widget.contentBuilder!(context, widget.initialUri)
        : Platform.isLinux
        ? _MessagePanel(
            message: l10n.aicuWebViewUnsupported,
            actionLabel: l10n.aicuOpenInBrowser,
            onAction: _openCurrentPageExternally,
          )
        : _loadFailed
        ? _MessagePanel(
            message: l10n.aicuLookupLoadFailed,
            actionLabel: l10n.commonRefresh,
            onAction: () {
              setState(() => _loadFailed = false);
              _controller?.reload();
            },
          )
        : _buildWebView();

    return Scaffold(
      key: const ValueKey('aicu-lookup-page'),
      appBar: AppBar(
        title: Text(l10n.aicuLookupTitle),
        actions: [
          IconButton(
            tooltip: l10n.commonRefresh,
            onPressed: widget.contentBuilder != null || !validInitialUri
                ? null
                : () {
                    setState(() => _loadFailed = false);
                    _controller?.reload();
                  },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: l10n.aicuOpenInBrowser,
            onPressed: validInitialUri ? _openCurrentPageExternally : null,
            icon: const Icon(Icons.open_in_browser_outlined),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: LinearProgressIndicator(
            value: _progress >= 1 ? 0 : _progress,
            minHeight: 2,
          ),
        ),
      ),
      body: ViewSafeArea(
        child: Column(
          children: [
            _ThirdPartyNotice(text: l10n.aicuThirdPartyNotice),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }

  Widget _buildWebView() => InAppWebView(
    initialSettings: InAppWebViewSettings(
      javaScriptEnabled: true,
      useShouldOverrideUrlLoading: true,
      mixedContentMode: MixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
      supportMultipleWindows: false,
      javaScriptCanOpenWindowsAutomatically: false,
    ),
    initialUrlRequest: URLRequest(url: WebUri.uri(widget.initialUri)),
    onWebViewCreated: (controller) => _controller = controller,
    onProgressChanged: (_, progress) {
      if (mounted) setState(() => _progress = progress / 100);
    },
    onLoadStart: (_, uri) {
      if (!mounted) return;
      setState(() {
        _currentUri = uri?.uriValue ?? _currentUri;
        _loadFailed = false;
      });
    },
    onLoadStop: (_, uri) {
      if (!mounted) return;
      setState(() {
        _currentUri = uri?.uriValue ?? _currentUri;
        _loadFailed = false;
        _progress = 1;
      });
    },
    onReceivedError: (_, request, __) {
      if (request.isForMainFrame == true && mounted) {
        setState(() => _loadFailed = true);
      }
    },
    shouldOverrideUrlLoading: (_, action) async {
      final uri = action.request.url?.uriValue;
      if (uri == null ||
          !AicuUrlPolicy.allowsNavigation(
            uri,
            isMainFrame: action.isForMainFrame,
          )) {
        _showBlockedNavigation(uri);
        return NavigationActionPolicy.CANCEL;
      }
      return NavigationActionPolicy.ALLOW;
    },
  );
}

class _ThirdPartyNotice extends StatelessWidget {
  const _ThirdPartyNotice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: colors.secondaryContainer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 18, color: colors.onSecondaryContainer),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: colors.onSecondaryContainer,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessagePanel extends StatelessWidget {
  const _MessagePanel({
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.public_off_outlined,
            size: 34,
            color: ColorScheme.of(context).outline,
          ),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 12),
            FilledButton.tonal(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    ),
  );
}
