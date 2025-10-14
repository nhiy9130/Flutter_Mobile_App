import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const ListTile(title: Text('Theme')),
          RadioListTile<ThemeMode>(
            value: ThemeMode.system,
            groupValue: theme.mode,
            onChanged: (m) => ref.read(appThemeProvider.notifier).setMode(m ?? ThemeMode.system),
            title: const Text('System'),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.light,
            groupValue: theme.mode,
            onChanged: (m) => ref.read(appThemeProvider.notifier).setMode(m ?? ThemeMode.light),
            title: const Text('Light'),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.dark,
            groupValue: theme.mode,
            onChanged: (m) => ref.read(appThemeProvider.notifier).setMode(m ?? ThemeMode.dark),
            title: const Text('Dark'),
          ),
          const Divider(),
          const ListTile(title: Text('Language')),
          ListTile(
            title: const Text('Tiếng Việt'),
            onTap: () => context.setLocale(const Locale('vi')),
          ),
          ListTile(
            title: const Text('English'),
            onTap: () => context.setLocale(const Locale('en')),
          ),
        ],
      ),
    );
  }
}



