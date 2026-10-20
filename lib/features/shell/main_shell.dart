import 'package:flutter/material.dart';

/// Temporary main screen so that login/registration can navigate somewhere
/// Replaced by the real shell with bottom navigation in stage 3
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Головна')),
      body: const Center(child: Text('Головний екран з’явиться на етапі 3')),
    );
  }
}
