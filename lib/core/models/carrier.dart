import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Postal carriers supported by the app
enum Carrier {
  novaPoshta(
    initials: 'НП',
    title: 'Нова пошта',
    color: AppColors.novaPoshta,
    onColor: Colors.white,
  ),
  ukrposhta(
    initials: 'УП',
    title: 'Укрпошта',
    color: AppColors.ukrposhta,
    onColor: Color(0xFF3A2E00),
  ),
  meest(
    initials: 'M',
    title: 'Meest',
    color: AppColors.meest,
    onColor: Colors.white,
  );

  const Carrier({
    required this.initials,
    required this.title,
    required this.color,
    required this.onColor,
  });

  final String initials;
  final String title;
  final Color color;
  final Color onColor;
}
