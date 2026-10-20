import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Delivery status of a parcel with its label, icon and color tone
enum ParcelStatus {
  inTransit(
    label: 'У дорозі',
    icon: Icons.local_shipping_outlined,
    tone: AppTone.blue,
  ),
  atBranch(
    label: 'У відділенні',
    icon: Icons.storefront_outlined,
    tone: AppTone.orange,
  ),
  returned(label: 'Повернення', icon: Icons.undo, tone: AppTone.grey),
  received(
    label: 'Отримано',
    icon: Icons.check_circle_outline,
    tone: AppTone.green,
  );

  const ParcelStatus({
    required this.label,
    required this.icon,
    required this.tone,
  });

  final String label;
  final IconData icon;
  final AppTone tone;
}
