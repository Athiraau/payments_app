// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import 'package:local_session_timeout/local_session_timeout.dart';
//
// enum AppSessionState { active, expired }
//
// class SessionProvider with ChangeNotifier {
//   SessionState _sessionState = SessionState.active;
//   final StreamController<SessionState> _sessionStateController = StreamController<SessionState>.broadcast();
//
//   SessionProvider() {
//     // Listen to session state changes
//     _sessionStateController.stream.listen((state) {
//       print("sate $state");
//       // _sessionState = state.name;
//       notifyListeners();
//     });
//   }
//
//   AppSessionState get sessionState => _sessionState;
//
//   void expireSession() {
//     _sessionStateController.add(AppSessionState.expired);
//   }
//
//   void refreshSession() {
//     _sessionStateController.add(AppSessionState.active);
//   }
//
//   @override
//   void dispose() {
//     _sessionStateController.close();
//     super.dispose();
//   }
// }
