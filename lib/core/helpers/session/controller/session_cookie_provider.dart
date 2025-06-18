import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_html/html.dart' as html;

import '../../../utils/shared/component/widgets/custom_toast.dart';
import '../../routes/app_route_name.dart';

class CookieSessionProvider extends ChangeNotifier {
  String? _sessionId;
  String? get sessionId => _sessionId;

  ///Create session
  void setSession({required String id, required int minutes}) {
    _sessionId = id;
    _setCookie(name: 'session_id', value: id, minutes: minutes);
    notifyListeners();
  }

  /// Clears the current session.
  void clearSession() {
    _sessionId = null;
    _deleteCookie('session_id');
    notifyListeners();
  }

  /// Checks if the session is active.
  void isSessionActive(BuildContext context) {
    if (_sessionId != null) {
      CustomToast.showCustomErrorToast(message: "Active session");
      notifyListeners();
    } else {
      clearSession();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomToast.showCustomErrorToast(message: "Active session");
        context.goNamed(RoutesName.session_expires);
        notifyListeners();
      });
    }
  }

  /// Sets a cookie with a specified expiration time.
  void _setCookie(
      {required String name, required String value, required int minutes}) {
    final DateTime now = DateTime.now();
    final DateTime expiryDate = now.add(Duration(minutes: minutes));
    final String expires = 'expires=${expiryDate.toUtc().toIso8601String()}';
    html.document.cookie = '$name=$value; $expires; path=/; SameSite=Lax';
  }

  /// Deletes a cookie by name.
  void _deleteCookie(String name) {
    html.document.cookie =
        '$name=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
  }

  /// Loads the session from the cookie.
  void loadSession() {
    _sessionId = _getCookie('session_id');
    notifyListeners();
  }

  /// Retrieves a cookie value by name.
  String? _getCookie(String name) {
    // Get the cookie string and ensure it's not null
    final String cookieString = html.document.cookie!;

    // Split the cookie string into individual cookies and create a map
    final Map<String, String> cookieMap = Map.fromEntries(
      cookieString.split("; ").map((item) {
        final split = item.split("=");
        return MapEntry(split[0], split.length > 1 ? split[1] : '');
      }),
    );
    return cookieMap[name];
  }
}
