import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// "Немає акаунта? Зареєструватися" style row: plain text + text link
class InlineLink extends StatelessWidget {
  const InlineLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  final String text;
  final String linkText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: Theme.of(context).textTheme.bodySmall),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            minimumSize: const Size(0, 40),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: Text(linkText),
        ),
      ],
    );
  }
}
