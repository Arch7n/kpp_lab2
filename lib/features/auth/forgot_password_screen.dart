import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';

/// Password recovery screen. "Надіслати лист" only shows a SnackBar
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  void _sendEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Лист для відновлення пароля надіслано')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Відновлення пароля')),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.xxl,
            AppSpacing.screen,
            AppSpacing.lg,
          ),
          child: Column(
            children: [
              const IconBadge(icon: Icons.lock_reset, circle: true),
              const SizedBox(height: AppSpacing.xl),
              Text('Забули пароль?', style: textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Введіть email, вказаний під час реєстрації. Ми надішлемо '
                'посилання для створення нового пароля.',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const AppTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: 'Надіслати лист',
                onPressed: () => _sendEmail(context),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Не отримали лист? Перевірте папку «Спам» або надішліть '
                'повторно через 60 с.',
                textAlign: TextAlign.center,
                style: textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
