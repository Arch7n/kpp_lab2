import 'package:flutter/material.dart';

import '../models/parcel_status.dart';
import '../theme/app_colors.dart';

/// Small colored label with an icon: "У дорозі", "У відділенні", ...
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final ParcelStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(status.tone, Theme.of(context).brightness);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 12, color: colors.foreground),
          const SizedBox(width: 4),
          Text(
            status.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: colors.foreground,
            ),
          ),
        ],
      ),
    );
  }
}
