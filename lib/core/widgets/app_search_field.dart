import 'package:flutter/material.dart';

/// Rounded search field with a clear button that appears only when
/// the field is not empty
class AppSearchField extends StatefulWidget {
  const AppSearchField({super.key, required this.hintText, this.onChanged});

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  final TextEditingController _controller = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _showClearButton) {
      setState(() => _showClearButton = hasText);
    }
    widget.onChanged?.call(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _showClearButton
            ? IconButton(
                tooltip: 'Очистити',
                icon: const Icon(Icons.close),
                onPressed: _controller.clear,
              )
            : null,
        filled: true,
        fillColor: scheme.surfaceContainerHigh,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
