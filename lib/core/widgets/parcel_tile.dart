import 'package:flutter/material.dart';

import '../models/parcel.dart';
import 'carrier_avatar.dart';

/// Compact list row used in the "Останні зміни" section of the home screen
class ParcelTile extends StatelessWidget {
  const ParcelTile({super.key, required this.parcel, this.onTap});

  final Parcel parcel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CarrierAvatar(carrier: parcel.carrier),
      title: Text(
        parcel.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleSmall,
      ),
      subtitle: Text(
        '${parcel.status.label}, ${parcel.updatedAt}',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
