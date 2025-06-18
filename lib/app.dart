import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_payment_app/core/helpers/routes/app_route_name.dart';
import 'package:go_router/go_router.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'core/helpers/routes/app_route_config.dart';
import 'core/helpers/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final sessionStateStream = StreamController<SessionState>();
  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(minutes: 15),
      invalidateSessionForUserInactivity: const Duration(minutes: 30),
    );

    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        if (context.mounted) {
          context.goNamed(RoutesName.session_expires);
        }
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        if (context.mounted) {
          context.goNamed(RoutesName.session_expires);
        }
      }
    });

    return SessionTimeoutManager(
      userActivityDebounceDuration: const Duration(seconds: 1),
      sessionConfig: sessionConfig,
      sessionStateStream: sessionStateStream.stream,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Payments Applications',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRoutes(
          rootNavigatorKey: _rootNavigatorKey,
        ).appRouter,
      ),
    );
  }
}
