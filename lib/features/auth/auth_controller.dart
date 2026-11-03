import 'dart:async';

import '../../core/models/app_user.dart';
import '../../core/services/analytics_service.dart';
import '../../core/services/crash_reporter.dart';
import '../../core/utils/async_controller.dart';
import 'data/auth_repository.dart';
import '../../core/errors/auth_failure.dart';

/// Стан і дії екранів входу / реєстрації / відновлення пароля.
/// Кожен метод повертає true при успіху. Помилку й loading
/// екран бере з [errorMessage] та [isLoading].
class AuthController extends AsyncController {
  AuthController(this._repo) {
    _sub = _repo.authStateChanges.listen(_onAuthChanged);
  }

  final AuthRepository _repo;
  late final StreamSubscription<AppUser?> _sub;

  /// Прив’язуємо аналітику й Crashlytics до uid (не до email!).
  void _onAuthChanged(AppUser? user) {
    unawaited(AnalyticsService.instance.setUserId(user?.uid));
    unawaited(CrashReporter.setUser(user?.uid));
  }

  Future<bool> signIn({required String email, required String password}) =>
      run(() async {
        await _repo.signIn(email: email, password: password);
        unawaited(AnalyticsService.instance.logLogin('password'));
      }, reason: 'signIn');

  Future<bool> signUp({
    required String displayName,
    required String email,
    required String password,
  }) =>
      run(() async {
        await _repo.signUp(
          email: email,
          password: password,
          displayName: displayName,
        );
        unawaited(AnalyticsService.instance.logSignUp('password'));
      }, reason: 'signUp');

  Future<bool> signInWithGoogle() => run(() async {
        final isNew = await _repo.signInWithGoogle();
        unawaited(
          isNew
              ? AnalyticsService.instance.logSignUp('google')
              : AnalyticsService.instance.logLogin('google'),
        );
      }, reason: 'signInWithGoogle');

  /// Завжди показуємо нейтральний результат: не розкриваємо,
  /// чи існує акаунт із такою поштою.
  Future<bool> sendPasswordReset(String email) => run(() async {
        try {
          await _repo.sendPasswordReset(email);
        } on AuthFailure catch (e) {
          if (e.code != 'user-not-found') rethrow;
        }
      }, reason: 'sendPasswordReset');

  /// Після виходу AuthGate сам покаже екран входу.
  Future<bool> signOut() => run(_repo.signOut, reason: 'signOut');

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
