import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/src/features/dashboard/document_model.dart';
import 'package:myapp/src/features/dashboard/documents_provider.dart';
import 'package:myapp/widgets/app_header.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  // Función para lanzar URLs, necesaria para el botón de WhatsApp
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('No se pudo lanzar $url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsync = ref.watch(documentsProvider);
    final theme = Theme.of(context);

    const phoneNumber = "525583252920";
    // Se usa una función JS global `encodeURIComponent` que no existe en Dart.
    // Dart tiene `Uri.encodeComponent` para esto.
    const message = "Hola quiero más información sobre...";
    final whatsappUrl = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea el título a la izquierda
        children: [
          const AppHeader(),
          // NUEVO: Título de la sección
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 16.0),
            child: Text(
              'Centro de Información',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            child: documentsAsync.when(
              data: (documents) => _buildDocumentsList(context, theme, documents),
              loading: () => const Center(child: CircularProgressIndicator()),
              // NUEVO: UI de error mejorada
              error: (err, stack) => _buildErrorWidget(theme, err.toString()),
            ),
          ),
        ],
      ),
      // NUEVO: Botón flotante de WhatsApp para coherencia
      floatingActionButton: FloatingActionButton(
        onPressed: () => _launchUrl(whatsappUrl),
        backgroundColor: Colors.transparent, // Fondo transparente
        elevation: 0,
        tooltip: 'Contactar por WhatsApp',
        child: Image.asset('assets/icon/logo-wp.png'), // Usa la nueva imagen
      ),
    );
  }

  // NUEVO: Widget para mostrar errores de forma más amigable
  Widget _buildErrorWidget(ThemeData theme, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off_rounded, color: theme.colorScheme.error, size: 60),
            const SizedBox(height: 20),
            Text(
              'Error de Conexión',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              // Muestra el error real de Supabase para depuración
              'No se pudo establecer conexión con el servidor de documentos. Por favor, inténtelo más tarde.\n\nDetalle: $error',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsList(BuildContext context, ThemeData theme, List<Document> documents) {
    if (documents.isEmpty) {
      return const Center(
        child: Text('No hay documentos disponibles en este momento.'),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      itemCount: documents.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final doc = documents[index];
        return _DocumentCard(document: doc);
      },
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final Document document;

  const _DocumentCard({required this.document});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconData = _getIconForCategory(document.category);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(iconData, color: theme.colorScheme.primary, size: 30),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    document.title,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              document.description,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () => _launchURL(document.downloadUrl),
                icon: const Icon(Icons.download_for_offline_outlined, size: 20),
                label: const Text('Descargar'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(DocumentCategory category) {
    switch (category) {
      case DocumentCategory.contratos:
        return Icons.gavel_rounded;
      case DocumentCategory.demandas:
        return Icons.shield_outlined;
      case DocumentCategory.identificaciones:
        return Icons.health_and_safety_outlined;
    }
  }
}
