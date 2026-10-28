abstract final class AicuUrlPolicy {
  static const host = 'www.aicu.cc';
  static const allowedTopLevelHosts = {'www.aicu.cc', 'aicu.cc', 'api.aicu.cc'};

  static Uri? replyForUid(int uid) {
    if (uid <= 0) return null;
    return Uri.https(host, '/reply', {'uid': '$uid'});
  }

  static bool isAllowedTopLevel(Uri uri) =>
      uri.scheme == 'https' &&
      uri.userInfo.isEmpty &&
      (uri.port == 443 || uri.hasPort == false) &&
      allowedTopLevelHosts.contains(uri.host.toLowerCase());

  static bool isAllowedResource(Uri uri) =>
      uri.scheme == 'https' &&
      uri.userInfo.isEmpty &&
      (uri.port == 443 || uri.hasPort == false);

  static bool allowsNavigation(Uri uri, {required bool? isMainFrame}) =>
      isAllowedResource(uri) &&
      (isMainFrame == false || isAllowedTopLevel(uri));
}
