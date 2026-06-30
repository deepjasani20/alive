import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_strings.dart';
import '../core/routes/app_pages.dart';
import '../core/theme/app_theme.dart';

/// Root widget. Uses [GetMaterialApp] so GetX can drive navigation, bindings and
/// dependency injection across the whole app.
class AliveApp extends StatelessWidget {
  const AliveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
    );
  }
}
