import 'package:flutter/material.dart';

/// Outlined text field used on every form of the app
///
/// Stateful only because a password field keeps its own "visible / hidden"
/// state, which is toggled with setState()
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
    this.showVisibilityToggle = true,
    this.helperText,
    this.suffixIcon,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool isPassword;

  /// Shows the eye icon for password fields
  final bool showVisibilityToggle;
  final String? helperText;

  /// Custom trailing widget; replaces the eye icon when provided
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;

  Widget? _buildSuffix() {
    if (widget.suffixIcon != null) return widget.suffixIcon;
    if (!widget.isPassword || !widget.showVisibilityToggle) return null;
    return IconButton(
      tooltip: _obscured ? 'Показати пароль' : 'Сховати пароль',
      icon: Icon(
        _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
      ),
      onPressed: () => setState(() => _obscured = !_obscured),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.isPassword
          ? TextInputType.visiblePassword
          : widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.isPassword && _obscured,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        helperText: widget.helperText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: _buildSuffix(),
      ),
    );
  }
}
