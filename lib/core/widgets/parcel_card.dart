import 'package:flutter/material.dart';

import '../models/parcel.dart';
import '../theme/app_spacing.dart';
import 'carrier_avatar.dart';
import 'status_chip.dart';

/// Card with carrier, title, tracking number, status and date
/// Used on the "Посилки" and "Архів" screens
class ParcelCard extends StatelessWidget {
  const ParcelCard({
    super.key,
    required this.parcel,
    this.onTap,
    this.faded = false,
  });

  final Parcel parcel;
  final VoidCallback? onTap;

  /// Muted carrier avatar for archived parcels
  final bool faded;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: scheme.surfaceContainer,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              CarrierAvatar(carrier: parcel.carrier, size: 44, faded: faded),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parcel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      parcel.trackingNumber,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        StatusChip(status: parcel.status),
                        const Spacer(),
                        Text(
                          parcel.updatedAt,
                          style: textTheme.labelSmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
