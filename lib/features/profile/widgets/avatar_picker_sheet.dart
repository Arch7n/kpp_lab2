import 'package:flutter/material.dart';

import '../../../core/utils/validators.dart';

/// Готові аватари з визначеними HTTPS-посиланнями (PNG).
/// Перевір у браузері, що посилання відкриваються, або заміни на свої.
const List<String> kAvatarPresets = [
  'https://api.dicebear.com/9.x/adventurer/png?seed=Felix&size=256',
  'https://api.dicebear.com/9.x/adventurer/png?seed=Aneka&size=256',
  'https://api.dicebear.com/9.x/adventurer/png?seed=Milo&size=256',
  'https://api.dicebear.com/9.x/adventurer/png?seed=Luna&size=256',
  'https://api.dicebear.com/9.x/bottts/png?seed=Robo&size=256',
  'https://api.dicebear.com/9.x/bottts/png?seed=Pixel&size=256',
];

/// Bottom sheet вибору фото профілю.
/// Повертає обране HTTPS-посилання або null (скасовано).
class AvatarPickerSheet extends StatefulWidget {
  const AvatarPickerSheet({super.key, this.currentUrl});

  final String? currentUrl;

  @override
  State<AvatarPickerSheet> createState() => _AvatarPickerSheetState();
}

class _AvatarPickerSheetState extends State<AvatarPickerSheet> {
  final _formKey = GlobalKey<FormState>();
  final _urlCtrl = TextEditingController();

  String? _preset; // обраний готовий аватар
  String? _customUrl; // коректне власне посилання (або null)

  String? get _chosen => _customUrl ?? _preset;

  @override
  void initState() {
    super.initState();
    if (kAvatarPresets.contains(widget.currentUrl)) {
      _preset = widget.currentUrl;
    }
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  void _onUrlChanged(String value) {
    final text = value.trim();
    setState(() {
      _customUrl = (text.isNotEmpty && Validators.httpsUrl(text) == null)
          ? text
          : null;
    });
  }

  void _selectPreset(String url) {
    setState(() {
      _preset = url;
      _customUrl = null;
      _urlCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 24 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Фото профілю', style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (var i = 0; i < kAvatarPresets.length; i++)
                Semantics(
                  button: true,
                  selected: _preset == kAvatarPresets[i] && _customUrl == null,
                  label: 'Аватар ${i + 1}',
                  child: GestureDetector(
                    onTap: () => _selectPreset(kAvatarPresets[i]),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: (_preset == kAvatarPresets[i] &&
                                  _customUrl == null)
                              ? theme.colorScheme.primary
                              : Colors.transparent,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: theme.colorScheme.surfaceContainerHighest,
                        backgroundImage: NetworkImage(kAvatarPresets[i]),
                        onBackgroundImageError: (_, __) {},
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _urlCtrl,
              keyboardType: TextInputType.url,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: _onUrlChanged,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? null
                  : Validators.httpsUrl(v),
              decoration: const InputDecoration(
                labelText: 'Або власне посилання (https://…)',
                prefixIcon: Icon(Icons.link),
              ),
            ),
          ),
          if (_customUrl != null) ...[
            const SizedBox(height: 16),
            Center(
              child: ClipOval(
                child: Image.network(
                  _customUrl!,
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => SizedBox(
                    width: 96,
                    height: 96,
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Попередній перегляд',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _chosen == null
                ? null
                : () => Navigator.of(context).pop(_chosen),
            child: const Text('Зберегти'),
          ),
        ],
      ),
    );
  }
}
