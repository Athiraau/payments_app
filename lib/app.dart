import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/helpers/routes/app_route_config.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Payments Applications',
      theme: ThemeData.dark(),
      routerConfig: AppRoutes().appRouter,
    );
  }
}