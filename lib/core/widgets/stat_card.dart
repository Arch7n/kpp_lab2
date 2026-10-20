import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Tonal card with an icon, a big number and a caption
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.tone,
    this.tag,
    this.onTap,
  });

  final IconData icon;
  final int value;
  final String label;
  final AppTone tone;

  /// Optional small note in the top-right corner, e.g. "безкоштовно до 03.10"
  final String? tag;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone, Theme.of(context).brightness);
    final textTheme = Theme.of(context).textTheme;
    final tagText = tag;

    return Material(
      color: colors.background,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: colors.foreground),
                  if (tagText != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        tagText,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.foreground,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '$value',
                style: textTheme.headlineMedium?.copyWith(
                  color: colors.foreground,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelLarge?.copyWith(color: colors.foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
