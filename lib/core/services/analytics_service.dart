import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Обгортка над Firebase Analytics. Жоден виклик не кидає виняток назовні:
/// збій аналітики не повинен ламати застосунок.
class AnalyticsService {
  AnalyticsService._();
  static final AnalyticsService instance = AnalyticsService._();

  FirebaseAnalytics get _fa => FirebaseAnalytics.instance;

  /// Альтернативний спосіб відстежувати екрани: додати в
  /// MaterialApp(navigatorObservers: [AnalyticsService.instance.observer]).
  /// Працює лише для маршрутів із RouteSettings(name: ...).
  late final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  Future<void> _safe(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      debugPrint('Analytics error: $e');
    }
  }

  // ---- Екрани ----
  Future<void> logScreen(String name) => _safe(
        () => _fa.logScreenView(screenName: name, screenClass: name),
      );

  // ---- Рекомендовані події ----
  Future<void> logLogin(String method) =>
      _safe(() => _fa.logLogin(loginMethod: method));

  Future<void> logSignUp(String method) =>
      _safe(() => _fa.logSignUp(signUpMethod: method));

  Future<void> setUserId(String? uid) => _safe(() => _fa.setUserId(id: uid));

  // ---- Власні події ParcelTrack (приклади, підлаштуй під свої дані) ----
  Future<void> logParcelAdded({required String carrier}) => _safe(
        () => _fa.logEvent(
          name: 'parcel_added',
          parameters: {'carrier': carrier},
        ),
      );

  Future<void> logParcelOpened({required String status}) => _safe(
        () => _fa.logEvent(
          name: 'parcel_opened',
          parameters: {'status': status},
        ),
      );
}
