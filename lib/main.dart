import 'package:flutter/material.dart';
import 'package:guess_it_frontend/core/get_it/get_it.dart';
import 'package:guess_it_frontend/core/router/app_router.dart';
import 'package:guess_it_frontend/core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(MaterialApp.router(
    routerConfig: AppRouter.router,
    theme: AppTheme.getTheme(),
    debugShowCheckedModeBanner: false,
  ));
}