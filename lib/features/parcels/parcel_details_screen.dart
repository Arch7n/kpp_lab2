import 'package:flutter/material.dart';

import '../../core/data/mock_data.dart';
import '../../core/models/parcel.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';
import 'widgets/parcel_files_tab.dart';
import 'widgets/parcel_history_tab.dart';

/// Parcel card with two tabs: history and files
class ParcelDetailsScreen extends StatelessWidget {
  const ParcelDetailsScreen({super.key, required this.parcel});

  final Parcel parcel;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(parcel.title),
          actions: [
            IconButton(
              onPressed: () {},
              tooltip: 'Більше',
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  AppSpacing.sm,
                  AppSpacing.screen,
                  AppSpacing.sm,
                ),
                child: _SummaryCard(parcel: parcel),
              ),
              const TabBar(
                tabs: [
                  Tab(text: 'Історія'),
                  Tab(text: 'Файли (3)'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [ParcelHistoryTab(), ParcelFilesTab()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.parcel});

  final Parcel parcel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final muted = textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StatusChip(status: parcel.status),
              const Spacer(),
              Text(parcel.trackingNumber, style: textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            MockData.branchTitle,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(MockData.branchAddress, style: muted),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.schedule, size: 16, color: AppColors.warning),
              const SizedBox(width: 6),
              Text(MockData.storageNote, style: textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
