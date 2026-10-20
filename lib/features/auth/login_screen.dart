import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';
import '../shell/main_shell.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

/// Login screen
/// "Увійти" simply opens the main screen as if login succeeded
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _login(BuildContext context) {
    // pushReplacement: the user cannot go "back" to the login screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const MainShell()),
    );
  }

  void _openForgotPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ForgotPasswordScreen()),
    );
  }

  void _openRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  56,
                  AppSpacing.screen,
                  AppSpacing.lg,
                ),
                child: Column(
                  children: [
                    const IconBadge(icon: Icons.local_shipping_outlined),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'ParcelTrack',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Усі посилки в одному місці',
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    const AppTextField(
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const AppTextField(
                      label: 'Пароль',
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _openForgotPassword(context),
                        child: const Text('Забули пароль?'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    PrimaryButton(
                      label: 'Увійти',
                      onPressed: () => _login(context),
                    ),
                  ],
                ),
              ),
            ),
            InlineLink(
              text: 'Немає акаунта?',
              linkText: 'Зареєструватися',
              onTap: () => _openRegister(context),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}
