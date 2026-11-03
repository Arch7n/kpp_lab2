import 'package:flutter/material.dart';

import '../../../core/utils/validators.dart';

/// Діалог зміни імені. Повертає нове ім’я або null (скасовано).
class EditNameDialog extends StatefulWidget {
  const EditNameDialog({super.key, required this.initialName});

  final String initialName;

  @override
  State<EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _ctrl =
      TextEditingController(text: widget.initialName);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_ctrl.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Змінити ім’я'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _save(),
          validator: Validators.displayName,
          decoration: const InputDecoration(labelText: 'Ім’я'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Скасувати'),
        ),
        FilledButton(onPressed: _save, child: const Text('Зберегти')),
      ],
    );
  }
}
