import 'package:firebase_auth/firebase_auth.dart';

/// Єдиний тип помилки автентифікації для решти застосунку.
/// Репозиторій перетворює FirebaseAuthException на AuthFailure з
/// повідомленням, зрозумілим користувачу (українською).
class AuthFailure implements Exception {
  const AuthFailure(this.code, this.message, {this.unexpected = false});

  final String code;
  final String message;

  /// true — помилка, якої ми не очікували (варто відправити в Crashlytics
  /// як non-fatal). Звичайні помилки користувача (невірний пароль тощо) —
  /// false, їх у Crashlytics слати не треба.
  final bool unexpected;

  bool get requiresRecentLogin => code == 'requires-recent-login';

  static const Set<String> _cancelCodes = {
    'web-context-canceled',
    'canceled',
    'popup-closed-by-user',
    'cancelled-popup-request',
  };

  /// Користувач сам закрив вікно входу через Google.
  bool get isCancelled => _cancelCodes.contains(code);

  factory AuthFailure.fromFirebase(
    FirebaseAuthException e, {
    String? credentialMessage,
  }) {
    if (_cancelCodes.contains(e.code)) {
      return AuthFailure(e.code, '');
    }

    switch (e.code) {
      case 'invalid-email':
        return AuthFailure(e.code, 'Некоректний формат email');

      // Навмисно одне загальне повідомлення: не розкриваємо, чи існує
      // акаунт із таким email (захист від user enumeration).
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
      case 'invalid-login-credentials':
        return AuthFailure(
          e.code,
          credentialMessage ?? 'Не вдалося увійти. Перевірте email і пароль',
        );

      case 'email-already-in-use':
        return AuthFailure(e.code, 'Акаунт із таким email уже існує');
      case 'weak-password':
        return AuthFailure(e.code, 'Пароль занадто слабкий');
      case 'too-many-requests':
        return AuthFailure(e.code, 'Забагато спроб. Спробуйте пізніше');
      case 'network-request-failed':
        return AuthFailure(e.code, 'Немає зʼєднання з інтернетом');
      case 'user-disabled':
        return AuthFailure(e.code, 'Цей акаунт заблоковано');
      case 'requires-recent-login':
        return AuthFailure(
          e.code,
          'Для цієї дії потрібно повторно підтвердити пароль',
        );
      case 'account-exists-with-different-credential':
        return AuthFailure(
          e.code,
          'Акаунт із таким email уже існує з іншим способом входу. '
          'Увійдіть за email і паролем, а Google привʼяжіть у профілі',
        );
      case 'credential-already-in-use':
        return AuthFailure(
          e.code,
          'Цей акаунт Google уже привʼязаний до іншого користувача',
        );
      case 'provider-already-linked':
        return AuthFailure(e.code, 'Цей спосіб входу вже привʼязано');
      case 'operation-not-allowed':
        // Помилка конфігурації: провайдер не увімкнено в Firebase Console.
        return AuthFailure(
          e.code,
          'Цей спосіб входу зараз недоступний',
          unexpected: true,
        );
      default:
        return AuthFailure(
          e.code,
          'Сталася помилка. Спробуйте ще раз',
          unexpected: true,
        );
    }
  }

  @override
  String toString() => 'AuthFailure($code)';
}
