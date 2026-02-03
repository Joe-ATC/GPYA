import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/src/features/dashboard/document_model.dart';
import 'package:myapp/src/features/dashboard/documents_provider.dart';
import 'package:myapp/widgets/app_header.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final whatsappUrl =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    return Scaffold(
      appBar: const AppHeader(),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinea el título a la izquierda
        children: [
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
              data: (documents) =>
                  _buildDocumentsList(context, theme, documents),
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
            Icon(
              Icons.cloud_off_rounded,
              color: theme.colorScheme.error,
              size: 60,
            ),
            const SizedBox(height: 20),
            Text(
              'Error de Conexión',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
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

  Widget _buildDocumentsList(
    BuildContext context,
    ThemeData theme,
    List<Document> documents,
  ) {
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

class _DocumentCard extends StatefulWidget {
  final Document document;

  const _DocumentCard({required this.document});

  @override
  State<_DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<_DocumentCard> {
  // Estado de descarga
  bool _isDownloading = false;
  double _progress = 0.0;
  String? _filePath;
  bool _isDownloaded = false;

  @override
  void initState() {
    super.initState();
    _checkFileExists();
  }

  // Verifica si el archivo ya existe localmente
  Future<void> _checkFileExists() async {
    // Lógica simple por ahora, se podría mejorar persistiendo descargas
  }

  Future<void> _downloadFile() async {
    final platform = Theme.of(context).platform;

    // 1. Solicitar permisos (Android < 13 requiere Storage, Android 13+ fotos/videos/audio)
    // Para simplificar y compatibilidad, intentamos acceder al directorio público.
    // Nota: En Android 13+ con Scope Storage, escribir en Downloads suele ser permitido sin permiso EXPLÍCITO si usamos MediaStore o rutas públicas.

    // Verificamos permisos básicos solo si es necesario (Android < 11 principalmente)
    if (await Permission.storage.request().isDenied) {
      // Intentamos continuar, algunos dispositivos nuevos no dan este permiso pero dejan escribir en Downloads
    }

    setState(() {
      _isDownloading = true;
      _progress = 0.0;
    });

    try {
      final dio = Dio();

      // Obtener directorio de descargas
      Directory? downloadsDir;
      if (platform == TargetPlatform.android) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else {
        downloadsDir = await getDownloadsDirectory();
      }

      if (downloadsDir == null) {
        throw Exception('No se pudo encontrar el directorio de descargas');
      }

      if (!downloadsDir.existsSync()) {
        downloadsDir.createSync(); // Intentar crear si no existe
      }

      // Nombre del archivo
      final fileName =
          '${widget.document.title.replaceAll(RegExp(r'[^\w\s\.-]'), '')}.pdf';
      final savePath = '${downloadsDir.path}/$fileName';
      final file = File(savePath);

      // Verificamos si ya existe
      if (file.existsSync()) {
        if (mounted) {
          setState(() {
            _isDownloading = false;
            _isDownloaded = true;
            _filePath = savePath;
            _progress = 1.0;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Este documento ya se ha descargado: $fileName'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }
        return; // Salimos para no re-descargar
      }

      await dio.download(
        widget.document.downloadUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _progress = received / total;
            });
          }
        },
      );

      if (mounted) {
        setState(() {
          _isDownloading = false;
          _isDownloaded = true;
          _filePath = savePath;
          _progress = 1.0;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Descarga completada: $fileName')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _progress = 0.0;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al descargar: $e')));
      }
    }
  }

  Future<void> _openFile() async {
    if (_filePath != null) {
      final result = await OpenFilex.open(_filePath!);
      if (result.type != ResultType.done) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No se pudo abrir el archivo: ${result.message}'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconData = _getIconForCategory(widget.document.category);

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
                    widget.document.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.document.description,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Área de acciones (Barra de progreso o Botones)
            if (_isDownloading)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(_progress * 100).toStringAsFixed(0)}%',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              )
            else
              Align(
                alignment: Alignment.centerRight,
                child: _isDownloaded
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: _downloadFile,
                            icon: const Icon(Icons.download_rounded),
                            tooltip: 'Descargar nuevamente',
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _openFile,
                            icon: const Icon(
                              Icons.visibility_outlined,
                              size: 20,
                            ),
                            label: const Text('Abrir'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.secondary,
                              foregroundColor: theme.colorScheme.onSecondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ],
                      )
                    : ElevatedButton.icon(
                        onPressed: _downloadFile,
                        icon: const Icon(
                          Icons.download_for_offline_outlined,
                          size: 20,
                        ),
                        label: const Text('Descargar'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                      ),
              ),
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
