import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/src/features/dashboard/document_model.dart';
import 'package:myapp/src/features/dashboard/documents_provider.dart';
import 'package:myapp/widgets/app_header.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsync = ref.watch(documentsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(), 
          Expanded(
            child: documentsAsync.when(
              data: (documents) => _buildDocumentsList(context, theme, documents),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsList(BuildContext context, ThemeData theme, List<Document> documents) {
    return ListView.separated(
      padding: const EdgeInsets.all(24.0),
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
