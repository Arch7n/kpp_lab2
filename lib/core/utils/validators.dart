/// Чисті функції валідації для TextFormField.validator.
/// Контракт: повернути текст помилки або null, якщо значення коректне.
class Validators {
  Validators._();

  static final RegExp _emailRegExp =
      RegExp(r"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$");
  static final RegExp _letter = RegExp(r'\p{L}', unicode: true);
  static final RegExp _digit = RegExp(r'\d');

  static String? displayName(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Введіть ім’я';
    if (v.length < 2) return 'Ім’я має містити щонайменше 2 символи';
    if (v.length > 50) return 'Ім’я занадто довге (максимум 50 символів)';
    return null;
  }

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Введіть email';
    if (!_emailRegExp.hasMatch(v)) return 'Невірний формат email';
    return null;
  }

  /// Для екрана входу: лише «не порожній» (політику складності
  /// перевіряємо під час реєстрації та зміни пароля).
  static String? requiredPassword(String? value) {
    if (value == null || value.isEmpty) return 'Введіть пароль';
    return null;
  }

  /// Для реєстрації та зміни пароля.
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Введіть пароль';
    if (value.length < 8) return 'Пароль має містити щонайменше 8 символів';
    if (!_letter.hasMatch(value)) return 'Додайте хоча б одну літеру';
    if (!_digit.hasMatch(value)) return 'Додайте хоча б одну цифру';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Повторіть пароль';
    if (value != original) return 'Паролі не збігаються';
    return null;
  }

  /// Лише абсолютні HTTPS-посилання (для фото профілю).
  static String? httpsUrl(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Введіть посилання';
    final uri = Uri.tryParse(v);
    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      return 'Потрібне посилання, що починається з https://';
    }
    return null;
  }
}
