import '../../core/utils/async_controller.dart';
import '../auth/data/auth_repository.dart';

/// Стан і дії екранів профілю: ім’я, фото, зміна пароля, привʼязка Google.
class ProfileController extends AsyncController {
  ProfileController(this._repo);

  final AuthRepository _repo;

  /// true, якщо остання операція завершилась помилкою requires-recent-login.
  bool get requiresRecentLogin => lastFailure?.requiresRecentLogin ?? false;

  Future<bool> updateDisplayName(String name) =>
      run(() => _repo.updateDisplayName(name.trim()),
          reason: 'updateDisplayName');

  Future<bool> updatePhotoUrl(String url) =>
      run(() => _repo.updatePhotoUrl(url.trim()), reason: 'updatePhotoUrl');

  Future<bool> changePassword(String newPassword) =>
      run(() => _repo.changePassword(newPassword), reason: 'changePassword');

  Future<bool> reauthenticate(String password) =>
      run(() => _repo.reauthenticate(password), reason: 'reauthenticate');

  Future<bool> linkGoogle() => run(_repo.linkGoogle, reason: 'linkGoogle');
}
