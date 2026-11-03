import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/errors/auth_failure.dart';
import '../../../core/models/app_user.dart';

/// Єдине місце в застосунку, де використовується FirebaseAuth.
/// Не знає про BuildContext, SnackBar, навігацію чи стан екранів:
/// або виконує операцію, або кидає [AuthFailure].
class AuthRepository {
  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  /// Потік стану сеансу (вхід/вихід + відновлення сеансу при старті).
  /// `late final` — щоб StreamBuilder не підписувався заново на кожен build.
  late final Stream<AppUser?> authStateChanges =
      _auth.authStateChanges().map(_toAppUser);

  /// Поточний користувач (завжди свіжі дані після reload()).
  AppUser? get currentUser => _toAppUser(_auth.currentUser);

  // --------------------------------------------------------------------
  // Реєстрація / вхід / вихід
  // --------------------------------------------------------------------

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) =>
      _guard(() async {
        final cred = await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );
        final name = displayName?.trim();
        if (name != null && name.isNotEmpty) {
          await cred.user?.updateDisplayName(name);
          await cred.user?.reload();
        }
      });

  Future<void> signIn({required String email, required String password}) =>
      _guard(() async {
        await _auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );
      });

  /// Вхід через Google (нативний OAuth-потік Firebase, без пакета google_sign_in).
  /// Повертає true, якщо акаунт щойно створено (для події sign_up в Analytics).
  Future<bool> signInWithGoogle() => _guard(() async {
        final provider = GoogleAuthProvider()
          ..setCustomParameters({'prompt': 'select_account'});
        final cred = await _auth.signInWithProvider(provider);
        return cred.additionalUserInfo?.isNewUser ?? false;
      });

  Future<void> signOut() => _guard(() => _auth.signOut());

  Future<void> sendPasswordReset(String email) =>
      _guard(() => _auth.sendPasswordResetEmail(email: email.trim()));

  // --------------------------------------------------------------------
  // Профіль
  // --------------------------------------------------------------------

  Future<void> updateDisplayName(String name) => _guard(() async {
        final user = _requireUser();
        await user.updateDisplayName(name);
        await user.reload();
      });

  /// Зберігає лише посилання (файл не завантажується — це ЛР6).
  Future<void> updatePhotoUrl(String url) => _guard(() async {
        final user = _requireUser();
        await user.updatePhotoURL(url);
        await user.reload();
      });

  /// Може кинути AuthFailure з кодом requires-recent-login.
  Future<void> changePassword(String newPassword) =>
      _guard(() => _requireUser().updatePassword(newPassword));

  /// Повторна автентифікація паролем (для requires-recent-login).
  Future<void> reauthenticate(String password) => _guard(
        () async {
          final user = _requireUser();
          final email = user.email;
          if (email == null) {
            throw const AuthFailure(
              'no-email',
              'У цього акаунта немає email для підтвердження',
            );
          }
          await user.reauthenticateWithCredential(
            EmailAuthProvider.credential(email: email, password: password),
          );
        },
        credentialMessage: 'Невірний пароль',
      );

  /// Зв’язує Google з поточним акаунтом (один профіль — кілька способів входу).
  Future<void> linkGoogle() => _guard(() async {
        final user = _requireUser();
        await user.linkWithProvider(GoogleAuthProvider());
        await user.reload();
      });

  // --------------------------------------------------------------------
  // Внутрішні допоміжні методи
  // --------------------------------------------------------------------

  User _requireUser() {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthFailure(
        'no-current-user',
        'Сеанс завершився. Увійдіть знову',
      );
    }
    return user;
  }

  /// Перетворює FirebaseAuthException на AuthFailure (зі збереженням stack trace).
  Future<T> _guard<T>(
    Future<T> Function() action, {
    String? credentialMessage,
  }) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e, st) {
      Error.throwWithStackTrace(
        AuthFailure.fromFirebase(e, credentialMessage: credentialMessage),
        st,
      );
    }
  }

  AppUser? _toAppUser(User? user) {
    if (user == null) return null;
    final providers = user.providerData.map((p) => p.providerId).toSet();
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      hasPassword: providers.contains('password'),
      hasGoogle: providers.contains('google.com'),
    );
  }
}
