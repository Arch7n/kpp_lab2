import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Section title with an optional action ("Усі")
/// [accent] gives the small blue style used in the profile screen
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.accent = false,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = accent
        ? theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)
        : theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600);
    final action = actionLabel;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          if (action != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(action),
            ),
        ],
      ),
    );
  }
}
