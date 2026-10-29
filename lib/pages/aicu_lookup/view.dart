import 'dart:io' show Platform;

import 'package:ex_piliplus/common/widgets/view_safe_area.dart';
import 'package:ex_piliplus/pages/aicu_lookup/aicu_webview_session.dart';
import 'package:ex_piliplus/utils/aicu_url_policy.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:flutter/foundation.dart'
    show ValueChanged, visibleForTesting;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:material_ui/material_ui.dart';

typedef AicuContentBuilder = Widget Function(BuildContext context, Uri uri);

class AicuLookupPage extends StatefulWidget {
  const AicuLookupPage({
    super.key,
    required this.initialUri,
    @visibleForTesting this.contentBuilder,
    @visibleForTesting this.onWebViewCreatedForTesting,
    @visibleForTesting this.onPageLoadedForTesting,
  });

  final Uri initialUri;
  @visibleForTesting
  final AicuContentBuilder? contentBuilder;
  @visibleForTesting
  final ValueChanged<InAppWebViewController>? onWebViewCreatedForTesting;
  @visibleForTesting
  final ValueChanged<Uri?>? onPageLoadedForTesting;

  @override
  State<AicuLookupPage> createState() => _AicuLookupPageState();
}

class _AicuLookupPageState extends State<AicuLookupPage> {
  InAppWebViewController? _controller;
  Uri? _currentUri;
  double _progress = 0;
  final AicuWebViewSession _webViewSession = AicuWebViewSession();

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

  void _retryLoad() {
    // The failed view is replaced by _MessagePanel, so its controller is no
    // longer attached. Recreate the WebView rather than reloading a stale
    // controller (especially after Android kills the renderer process).
    _controller = null;
    setState(() {
      _webViewSession.retry();
      _progress = 0;
    });
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
        : _webViewSession.loadFailed
        ? _MessagePanel(
            message: l10n.aicuLookupLoadFailed,
            actionLabel: l10n.commonRefresh,
            onAction: _retryLoad,
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
                : _retryLoad,
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
    key: ValueKey('aicu-webview-${_webViewSession.generation}'),
    initialSettings: InAppWebViewSettings(
      javaScriptEnabled: true,
      useShouldOverrideUrlLoading: true,
      useOnRenderProcessGone: true,
      mixedContentMode: MixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
      supportMultipleWindows: false,
      javaScriptCanOpenWindowsAutomatically: false,
    ),
    initialUrlRequest: URLRequest(
      url: WebUri.uri(_safeCurrentUri ?? widget.initialUri),
    ),
    onWebViewCreated: (controller) {
      _controller = controller;
      widget.onWebViewCreatedForTesting?.call(controller);
    },
    onProgressChanged: (_, progress) {
      if (mounted) setState(() => _progress = progress / 100);
    },
    onLoadStart: (_, uri) {
      if (!mounted) return;
      setState(() {
        _currentUri = uri?.uriValue ?? _currentUri;
        _webViewSession.markLoadStarted();
      });
    },
    onLoadStop: (_, uri) {
      if (!mounted) return;
      setState(() {
        _currentUri = uri?.uriValue ?? _currentUri;
        _webViewSession.markLoadStarted();
        _progress = 1;
      });
      widget.onPageLoadedForTesting?.call(uri?.uriValue);
    },
    onReceivedError: (_, request, __) {
      if (request.isForMainFrame == true && mounted) {
        setState(_webViewSession.markLoadFailed);
      }
    },
    onRenderProcessGone: (_, __) {
      if (!mounted) return;
      // Android WebView documents that the renderer may be killed under
      // resource pressure. Remove the dead platform view and offer an
      // explicit retry instead of letting the host app fail with it.
      _controller = null;
      setState(() {
        _webViewSession.markRendererProcessGone();
        _progress = 0;
      });
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

  Uri? get _safeCurrentUri {
    final uri = _currentUri;
    return uri != null && AicuUrlPolicy.isAllowedTopLevel(uri) ? uri : null;
  }
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
