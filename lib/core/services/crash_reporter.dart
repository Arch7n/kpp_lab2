import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Обгортка над Firebase Crashlytics.
/// ВАЖЛИВО: у reason/log не передаємо паролі, токени та email.
class CrashReporter {
  CrashReporter._();

  static FirebaseCrashlytics get _c => FirebaseCrashlytics.instance;

  /// Викликати в main() після Firebase.initializeApp().
  static Future<void> init() async {
    // Для лабораторної залишаємо збір увімкненим і в debug.
    // У реальному проєкті зазвичай: setCrashlyticsCollectionEnabled(!kDebugMode)
    await _c.setCrashlyticsCollectionEnabled(true);

    // Помилки, перехоплені фреймворком Flutter (віджети, рендер).
    FlutterError.onError = _c.recordFlutterFatalError;

    // Необроблені помилки поза Flutter-фреймворком (async-код, ізолят).
    PlatformDispatcher.instance.onError = (error, stack) {
      _c.recordError(error, stack, fatal: true);
      return true;
    };
  }

  /// Помилка, яку застосунок обробив і продовжив працювати (non-fatal).
  static Future<void> recordNonFatal(
    Object error,
    StackTrace? stack, {
    String? reason,
  }) async {
    try {
      await _c.recordError(error, stack, reason: reason, fatal: false);
    } catch (e) {
      debugPrint('Crashlytics recordNonFatal failed: $e');
    }
  }

  static Future<void> setUser(String? uid) async {
    try {
      await _c.setUserIdentifier(uid ?? '');
    } catch (e) {
      debugPrint('Crashlytics setUser failed: $e');
    }
  }

  /// Одна тестова помилка для лабораторної (скріншот у Firebase Console).
  /// Після виклику ПЕРЕЗАПУСТИ застосунок — non-fatal звіти відправляються
  /// при наступному запуску. У консолі дані зʼявляються із затримкою.
  static Future<void> sendTestError() async {
    await _c.log('Lab 4: manual test error');
    await _c.recordError(
      Exception('Lab 4 test non-fatal error (ParcelTrack)'),
      StackTrace.current,
      reason: 'Manual test for lab 4',
      fatal: false,
    );
  }

  /// Альтернатива: справжній аварійний збій (застосунок закриється).
  static void forceCrash() => _c.crash();
}
