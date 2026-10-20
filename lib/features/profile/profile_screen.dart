import 'package:flutter/material.dart';

import '../../core/data/mock_data.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';
import '../auth/login_screen.dart';
import 'change_password_screen.dart';

/// User profile. Notification switches keep local state only
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _statusNotifications = true;
  bool _storageReminders = true;

  void _openChangePassword() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ChangePasswordScreen()),
    );
  }

  void _logout() {
    // Remove every route and return to the login screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профіль'),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Налаштування',
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.sm,
          AppSpacing.screen,
          AppSpacing.xl,
        ),
        children: [
          Center(
            child: UserAvatar(
              initials: MockData.userInitials,
              radius: 40,
              onEditPhoto: () {},
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            MockData.userFullName,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 2),
          Text(
            MockData.userEmail,
            textAlign: TextAlign.center,
            style: textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SectionHeader(title: 'Особисті дані', accent: true),
          const _InfoRow(
            icon: Icons.phone_outlined,
            title: 'Телефон',
            value: MockData.userPhone,
          ),
          const _InfoRow(
            icon: Icons.language,
            title: 'Мова',
            value: 'Українська',
          ),
          const SectionHeader(title: 'Сповіщення', accent: true),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.notifications_active_outlined),
            title: const Text('Зміна статусу посилки'),
            value: _statusNotifications,
            onChanged: (value) => setState(() => _statusNotifications = value),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.schedule),
            title: const Text('Нагадування про зберігання'),
            value: _storageReminders,
            onChanged: (value) => setState(() => _storageReminders = value),
          ),
          const SectionHeader(title: 'Безпека', accent: true),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.lock_outline),
            title: const Text('Змінити пароль'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _openChangePassword,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.logout, color: scheme.error),
            title: Text('Вийти', style: TextStyle(color: scheme.error)),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}

/// Read-only row "icon - title - value" (phone, language)
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(
        value,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
