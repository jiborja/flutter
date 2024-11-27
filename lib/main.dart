import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/dependencyInjection/dependency_injection.dart';
//import 'package:presentation/firebase_options.dart';
import 'package:presentation/screens/login/login_screen.dart';
import 'package:presentation/shared/auth/auth_global_wrapper.dart';
import 'package:presentation/shared/routes.dart';
import 'package:presentation/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Firebase Crashlytics
  /// Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  configureInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AuthGlobalWrapper.build(
      navigatorKey: _navigatorKey,
      context: context,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'movies',
        theme: ligthTheme,
        initialRoute: LoginScreen.routeName,
        routes: AppRouter.routes,
        onGenerateRoute: AppRouter.onGenerateRoute,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
