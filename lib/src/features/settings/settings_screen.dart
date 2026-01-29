import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/src/features/settings/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: <Widget>[
          // Sección de Apariencia
          _buildSectionCard(
            theme,
            title: 'Apariencia',
            children: [_buildThemeSwitch(ref)],
          ),
          const SizedBox(height: 20),

          // Sección de Cuenta
          _buildSectionCard(
            theme,
            title: 'Cuenta',
            children: [
              ListTile(
                leading: Icon(Icons.logout, color: theme.colorScheme.error),
                title: Text('Cerrar Sesión', style: TextStyle(color: theme.colorScheme.error)),
                onTap: () async {
                  await Supabase.instance.client.auth.signOut();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(ThemeData theme, {required String title, required List<Widget> children}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSwitch(WidgetRef ref) {
    final currentMode = ref.watch(themeProvider);

    final options = {
      'Modo Claro': ThemeMode.light,
      'Modo Oscuro': ThemeMode.dark,
      'Automático (Sistema)': ThemeMode.system,
    };

    final icons = {
      ThemeMode.light: Icons.wb_sunny_outlined,
      ThemeMode.dark: Icons.nightlight_round_outlined,
      ThemeMode.system: Icons.brightness_auto_outlined,
    };

    return Column(
      children: options.entries.map((entry) {
        final title = entry.key;
        final value = entry.value;

        return ListTile(
          leading: Icon(icons[value]),
          title: Text(title),
          trailing: Radio<ThemeMode>(
            value: value,
            // ignore: deprecated_member_use
            groupValue: currentMode,
            // ignore: deprecated_member_use
            onChanged: (newValue) {
              if (newValue != null) {
                ref.read(themeProvider.notifier).setTheme(newValue);
              }
            },
          ),
          onTap: () {
            ref.read(themeProvider.notifier).setTheme(value);
          },
        );
      }).toList(),
    );
  }
}
