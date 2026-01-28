import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:myapp/screens/dashboard_screen.dart';

class SettingsScreen extends StatefulWidget {
  final GlobalKey<DashboardScreenState> dashboardKey;

  const SettingsScreen({super.key, required this.dashboardKey});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _clearCache() async {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final tempDir = await getTemporaryDirectory();
      int fileCount = 0;
      if (await tempDir.exists()) {
        final list = tempDir.listSync();
        fileCount = list.length;
        if (list.isNotEmpty) {
          await tempDir.delete(recursive: true);
          await tempDir.create();
        }
      }
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Caché limpiado. Se eliminaron $fileCount archivos.')),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error al limpiar el caché: $e')),
      );
    }
  }

  Future<void> _openAppSettings() async {
    await openAppSettings();
  }

  void _syncData() {
    widget.dashboardKey.currentState?.refreshDocuments();
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sincronizando datos...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Theme.of(context).colorScheme.surface.withAlpha(230),
              Colors.black,
            ],
            center: Alignment.topLeft,
            radius: 1.5,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionTitle(context, 'Mantenimiento'),
            _buildSettingsTile(
              context,
              icon: Icons.sync_rounded,
              title: 'Sincronizar Datos',
              subtitle: 'Recargar la lista de documentos desde el servidor.',
              onTap: _syncData,
            ),
            _buildSettingsTile(
              context,
              icon: Icons.cleaning_services_rounded,
              title: 'Limpiar Caché',
              subtitle: 'Elimina archivos temporales para liberar espacio.',
              onTap: _clearCache,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Aplicación'),
            _buildSettingsTile(
              context,
              icon: Icons.security_rounded,
              title: 'Permisos de la Aplicación',
              subtitle: 'Acceder a los ajustes de permisos del sistema.',
              onTap: _openAppSettings,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8, top: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface.withAlpha(128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title, style: theme.textTheme.titleMedium),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
