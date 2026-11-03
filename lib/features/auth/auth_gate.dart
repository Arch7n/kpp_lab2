import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/app_user.dart';
import '../shell/main_shell.dart';
import 'data/auth_repository.dart';
import 'login_screen.dart';

/// Кореневий віджет: вирішує, що показувати за станом сеансу.
///  - поки Firebase відновлює сеанс  -> індикатор;
///  - користувач є                   -> MainShell;
///  - користувача немає              -> LoginScreen.
/// Вхід і вихід НЕ навігують вручну: Gate реагує на потік сам.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<AuthRepository>();
    return StreamBuilder<AppUser?>(
      stream: repo.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.data != null) {
          return const MainShell(); // ← якщо в конструктора є параметри — додай
        }
        return const LoginScreen();
      },
    );
  }
}
