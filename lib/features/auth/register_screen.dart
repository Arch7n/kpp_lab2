import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';
import '../shell/main_shell.dart';

/// Registration screen without business logic
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void _register(BuildContext context) {
    // Clear the whole stack (login + register) and open the main screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const MainShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final mutedSmall = textTheme.bodySmall?.copyWith(
      color: scheme.onSurfaceVariant,
    );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  AppSpacing.sm,
                  AppSpacing.screen,
                  AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Створіть акаунт', style: textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Відстежуйте посилки всіх перевізників в одному застосунку',
                      style: mutedSmall,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    const AppTextField(
                      label: "Ім'я",
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const AppTextField(
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const AppTextField(
                      label: 'Пароль',
                      isPassword: true,
                      helperText: 'Мінімум 8 символів',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const AppTextField(
                      label: 'Підтвердження пароля',
                      isPassword: true,
                      showVisibilityToggle: false,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    PrimaryButton(
                      label: 'Зареєструватися',
                      onPressed: () => _register(context),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: Text(
                        'Реєструючись, ви погоджуєтеся з умовами використання',
                        textAlign: TextAlign.center,
                        style: mutedSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InlineLink(
              text: 'Вже є акаунт?',
              linkText: 'Увійти',
              onTap: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}
