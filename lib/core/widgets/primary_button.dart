import 'package:flutter/material.dart';

/// Full width rounded button. Size and shape come from the app theme
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.tonal = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  /// Light tonal variant (e.g. "Додати файл")
  final bool tonal;

  @override
  Widget build(BuildContext context) {
    final iconData = icon;
    if (iconData == null) {
      return tonal
          ? FilledButton.tonal(onPressed: onPressed, child: Text(label))
          : FilledButton(onPressed: onPressed, child: Text(label));
    }
    return tonal
        ? FilledButton.tonalIcon(
            onPressed: onPressed,
            icon: Icon(iconData),
            label: Text(label),
          )
        : FilledButton.icon(
            onPressed: onPressed,
            icon: Icon(iconData),
            label: Text(label),
          );
  }
}
