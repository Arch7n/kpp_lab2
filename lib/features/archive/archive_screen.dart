import 'package:flutter/material.dart';

import '../../core/data/mock_data.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';

/// Archive of received parcels (hardcoded data)
class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Архів')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.xs,
          AppSpacing.screen,
          AppSpacing.lg,
        ),
        children: [
          const AppSearchField(hintText: 'Пошук в архіві'),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Отримано посилок: ${MockData.archivedParcelsCount}',
            style: textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final parcel in MockData.archivedParcels)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: ParcelCard(parcel: parcel, faded: true),
            ),
        ],
      ),
    );
  }
}
