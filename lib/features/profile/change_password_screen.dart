import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';

/// Change password screen. The only UI state is the green check icon that
/// appears when the confirmation equals the new password
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _passwordsMatch = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_updateMatch);
    _confirmController.addListener(_updateMatch);
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _updateMatch() {
    final match = _confirmController.text.isNotEmpty &&
        _confirmController.text == _newPasswordController.text;
    if (match != _passwordsMatch) {
      setState(() => _passwordsMatch = match);
    }
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Пароль змінено')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Зміна пароля')),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.screen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Для безпеки спершу введіть поточний пароль',
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const AppTextField(
                      label: 'Поточний пароль',
                      isPassword: true,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppTextField(
                      label: 'Новий пароль',
                      controller: _newPasswordController,
                      isPassword: true,
                      helperText: 'Мінімум 8 символів, літери та цифри',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppTextField(
                      label: 'Підтвердження пароля',
                      controller: _confirmController,
                      isPassword: true,
                      showVisibilityToggle: false,
                      textInputAction: TextInputAction.done,
                      suffixIcon: _passwordsMatch
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: AppColors.success,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screen),
              child: PrimaryButton(label: 'Зберегти', onPressed: _save),
            ),
          ],
        ),
      ),
    );
  }
}
