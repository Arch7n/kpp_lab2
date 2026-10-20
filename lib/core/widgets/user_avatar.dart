import 'package:flutter/material.dart';

/// Round avatar with the user's initials and an optional "change photo" badge
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.initials,
    this.radius = 18,
    this.onEditPhoto,
  });

  final String initials;
  final double radius;

  /// When set, a camera badge is drawn over the bottom-right corner
  final VoidCallback? onEditPhoto;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: scheme.primaryContainer,
      foregroundColor: scheme.onPrimaryContainer,
      child: Text(
        initials,
        style: TextStyle(fontSize: radius * 0.75, fontWeight: FontWeight.w500),
      ),
    );

    final onEdit = onEditPhoto;
    if (onEdit == null) return avatar;

    // Stack + Positioned: the badge is placed on top of the avatar.
    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        Positioned(
          right: -2,
          bottom: -2,
          child: Material(
            color: scheme.primary,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onEdit,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 16,
                  color: scheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
