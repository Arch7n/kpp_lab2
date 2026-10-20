import 'package:flutter/material.dart';

import '../models/carrier.dart';

/// Colored circle with carrier initials (НП, УП, M)
class CarrierAvatar extends StatelessWidget {
  const CarrierAvatar({
    super.key,
    required this.carrier,
    this.size = 40,
    this.faded = false,
  });

  final Carrier carrier;
  final double size;

  /// Muted colors for archived parcels
  final bool faded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: faded ? carrier.color.withValues(alpha: 0.55) : carrier.color,
      ),
      child: Text(
        carrier.initials,
        style: TextStyle(
          color: carrier.onColor,
          fontSize: size * 0.32,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
