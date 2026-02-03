import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:myapp/src/features/settings/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('No se pudo lanzar $url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
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

          // Sección de Ayuda
          _buildSectionCard(
            theme,
            title: 'Ayuda y Soporte',
            children: [
              ListTile(
                leading: Icon(
                  Icons.support_agent_rounded,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('Contactar Soporte Técnico'),
                subtitle: const Text(
                  'area.tecnica@grupopadillayaguilar.com.mx',
                ),
                onTap: () => _launchUrl(
                  'mailto:area.tecnica@grupopadillayaguilar.com.mx',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Sección Legal
          _buildSectionCard(
            theme,
            title: 'Información Legal',
            children: [
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const Text('Términos y Condiciones'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _launchUrl(
                  'mailto:area.tecnica@grupopadillayaguilar.com.mx?subject=Consulta%20Términos%20y%20Condiciones',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('Política de Privacidad'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _launchUrl(
                  'mailto:area.tecnica@grupopadillayaguilar.com.mx?subject=Consulta%20Privacidad',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.gavel_outlined),
                title: const Text('Licencias de Código Abierto'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => showLicensePage(
                  context: context,
                  applicationName: 'GPYA',
                  applicationLegalese: '© 2026 Grupo Padilla y Aguilar',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    ThemeData theme, {
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
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
