import 'package:flutter/material.dart';

import '../../core/models/carrier.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';

/// New parcel form. The carrier is shown as "detected" with fixed demo data
class AddParcelScreen extends StatelessWidget {
  const AddParcelScreen({super.key});

  void _save(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Посилку додано')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Нова посилка')),
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
                    const AppTextField(label: 'Трек-номер'),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Перевізника визначено автоматично',
                      style: textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const _DetectedCarrier(carrier: Carrier.novaPoshta),
                    const SizedBox(height: AppSpacing.xl),
                    const AppTextField(label: 'Назва посилки'),
                    const SizedBox(height: AppSpacing.lg),
                    const AppTextField(
                      label: "Магазин (необов'язково)",
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    const InfoBanner(
                      text: 'Статус оновлюватиметься автоматично кожні '
                          '2 години. Про зміни ви отримаєте сповіщення.',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screen),
              child: PrimaryButton(
                label: 'Зберегти',
                onPressed: () => _save(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetectedCarrier extends StatelessWidget {
  const _DetectedCarrier({required this.carrier});

  final Carrier carrier;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarrierAvatar(carrier: carrier, size: 24),
          const SizedBox(width: AppSpacing.sm),
          Text(
            carrier.title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: scheme.onSecondaryContainer,
                ),
          ),
          const SizedBox(width: AppSpacing.xl),
          Icon(Icons.check, size: 18, color: scheme.onSecondaryContainer),
        ],
      ),
    );
  }
}
