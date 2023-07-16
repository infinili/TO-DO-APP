import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/app/config_repository.dart';
import 'package:untitled/app/logger.dart';

import '../firebase_options.dart';

abstract class Loc {
  static final _locator = GetIt.instance;

  static ConfigRepository get configRepository => _locator<ConfigRepository>();
  static FirebaseAnalytics get analytics => FirebaseAnalytics.instance;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initFirebase();
    _initCrashlytics();

    _locator.registerLazySingleton<FirebaseRemoteConfig>(
      () => FirebaseRemoteConfig.instance,
    );

    final configRepo = ConfigRepository(_locator<FirebaseRemoteConfig>());
    await configRepo.init();
    _locator.registerSingleton<ConfigRepository>(configRepo);
  }

  static Future<void> _initFirebase() async {
    MyLogger.instance.mes('Firebase initialization started');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    MyLogger.instance.mes('Firebase initialized');
  }

  static void _initCrashlytics() {
    FlutterError.onError = (errorDetails) {
      MyLogger.instance.mes('Caught error in FlutterError.onError');
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      MyLogger.instance.mes('Caught error in PlatformDispatcher.onError');
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );
      return true;
    };
    MyLogger.instance.mes('Crashlytics initialized');
  }
}
