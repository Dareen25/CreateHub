import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/di/di.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'l10n/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on Object {
    // The app can still open before the developer runs `flutterfire configure`.
    // Auth requests show a localized setup message until Firebase is configured.
  }
  await configureDependencies();
  runApp(const CreateHubApp());
}

class CreateHubApp extends StatelessWidget {
  const CreateHubApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'CreateHub',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    routerConfig: AppRouter.goRouter,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
