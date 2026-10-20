import 'package:flutter/material.dart';

/// Large tonal icon: the app logo tile on the login screen
/// or the round icon on the password recovery screen
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    this.size = 72,
    this.circle = false,
  });

  final IconData icon;
  final double size;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circle ? null : BorderRadius.circular(size * 0.25),
      ),
      child: Icon(icon, size: size * 0.45, color: scheme.onPrimaryContainer),
    );
  }
}
