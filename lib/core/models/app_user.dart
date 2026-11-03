/// Легка модель користувача для UI. Екрани не імпортують firebase_auth.
class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.hasPassword = false,
    this.hasGoogle = false,
  });

  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  /// Чи є в акаунта вхід за email/паролем (інакше змінити пароль не можна).
  final bool hasPassword;

  /// Чи привʼязаний Google до акаунта.
  final bool hasGoogle;

  String get titleName {
    final name = displayName?.trim();
    if (name != null && name.isNotEmpty) return name;
    return email ?? 'Користувач';
  }

  String get initial {
    final t = titleName;
    if (t.isEmpty) return '?';
    return String.fromCharCode(t.runes.first).toUpperCase();
  }
}
