import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/validators.dart';
import '../../../core/widgets/form_widgets.dart';
import '../profile_controller.dart';

/// Діалог повторної автентифікації (для помилки requires-recent-login).
/// Повертає true, якщо користувач успішно підтвердив пароль.
class ReauthDialog extends StatefulWidget {
  const ReauthDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ReauthDialog(),
    );
    return result ?? false;
  }

  @override
  State<ReauthDialog> createState() => _ReauthDialogState();
}

class _ReauthDialogState extends State<ReauthDialog> {
  final _formKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileController>().resetError();
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await context
        .read<ProfileController>()
        .reauthenticate(_passwordCtrl.text);
    if (ok && mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileController>();

    return AlertDialog(
      title: const Text('Підтвердіть особу'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'З міркувань безпеки введіть поточний пароль, щоб продовжити.',
              ),
              const SizedBox(height: 16),
              ErrorBanner(profile.errorMessage),
              PasswordFormField(
                controller: _passwordCtrl,
                label: 'Поточний пароль',
                enabled: !profile.isLoading,
                validator: Validators.requiredPassword,
                onSubmitted: _submit,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              profile.isLoading ? null : () => Navigator.of(context).pop(false),
          child: const Text('Скасувати'),
        ),
        FilledButton(
          onPressed: profile.isLoading ? null : _submit,
          child: profile.isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Підтвердити'),
        ),
      ],
    );
  }
}
