import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_spacing.dart';

/// "Історія" tab: vertical timeline of tracking events and action buttons
class ParcelHistoryTab extends StatelessWidget {
  const ParcelHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const events = MockData.trackingHistory;
    final pillButton = OutlinedButton.styleFrom(
      minimumSize: const Size(0, 40),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      side: BorderSide(color: scheme.primary),
      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    );

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.lg,
              AppSpacing.screen,
              AppSpacing.sm,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) => _TimelineItem(
              event: events[index],
              isCurrent: index == 0,
              isLast: index == events.length - 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                style: pillButton,
                icon: const Icon(Icons.share_outlined, size: 18),
                label: const Text('Поділитися'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                style: pillButton,
                icon: const Icon(Icons.archive_outlined, size: 18),
                label: const Text('В архів'),
              ),
              TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: scheme.error,
                  minimumSize: const Size(0, 40),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Видалити'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.event,
    required this.isCurrent,
    required this.isLast,
  });

  final TrackingEvent event;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final dot = Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrent ? scheme.primary : scheme.surface,
        border: Border.all(
          color: isCurrent ? scheme.primaryContainer : scheme.outline,
          width: isCurrent ? 3 : 1.5,
        ),
      ),
    );

    // IntrinsicHeight lets the connecting line stretch to the text height.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                const SizedBox(height: 2),
                dot,
                if (!isLast)
                  Expanded(
                    child: Container(width: 1.5, color: scheme.outlineVariant),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        event.time,
                        style: textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    event.subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
