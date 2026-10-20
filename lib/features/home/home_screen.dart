import 'package:flutter/material.dart';

import '../../core/data/mock_data.dart';
import '../../core/models/parcel.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';

/// Home screen: greeting, parcel summary and the latest status changes
///
/// The screen does not know about routes: navigation actions are passed in
/// as callbacks by MainShell, so the same widget works in any context
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.onSeeAll,
    this.onAddParcel,
    this.onOpenParcel,
  });

  final VoidCallback? onSeeAll;
  final VoidCallback? onAddParcel;
  final ValueChanged<Parcel>? onOpenParcel;

  /// Hardcoded user name instead of data from a backend
  static const String _userName = MockData.userGreetingName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final openParcel = onOpenParcel;
    final recentParcels = MockData.activeParcels.take(3);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Головна'),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Сповіщення',
            icon: const Icon(Icons.notifications_none),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.xs,
              right: AppSpacing.screen,
            ),
            child: UserAvatar(initials: MockData.userInitial),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddParcel,
        tooltip: 'Додати посилку',
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.sm,
          AppSpacing.screen,
          96,
        ),
        children: [
          Text('Привіт, $_userName!', style: textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'У вас ${MockData.activeParcelsCount} активних посилок',
            style: textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const _SummaryGrid(),
          const SizedBox(height: AppSpacing.sm),
          SectionHeader(
            title: 'Останні зміни',
            actionLabel: 'Усі',
            onAction: onSeeAll,
          ),
          // collection-for: one tile per parcel.
          for (final parcel in recentParcels)
            ParcelTile(
              parcel: parcel,
              onTap: openParcel == null ? null : () => openParcel(parcel),
            ),
        ],
      ),
    );
  }
}

/// 2x2 grid of summary cards built from Row + Expanded
class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.local_shipping_outlined,
                value: 3,
                label: 'У дорозі',
                tone: AppTone.blue,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: StatCard(
                icon: Icons.storefront_outlined,
                value: 2,
                label: 'У відділенні',
                tag: 'безкоштовно до 03.10',
                tone: AppTone.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.event_available_outlined,
                value: 1,
                label: 'Прибуде сьогодні',
                tone: AppTone.green,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: StatCard(
                icon: Icons.error_outline,
                value: 1,
                label: 'Потребують уваги',
                tone: AppTone.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
