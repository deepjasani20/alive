import 'package:alive_demo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/alive_app.dart';

/// App entry point.
///
/// Firebase is initialized best-effort: if the platform config files
/// (`google-services.json` / `GoogleService-Info.plist`) are not yet present,
/// the app still boots and the demo auth fallback kicks in. Once a real
/// Firebase project is attached, Google sign-in works against it automatically.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const AliveApp());
}
