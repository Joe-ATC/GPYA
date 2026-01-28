import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

// --- MODELO DE DATOS ---
class LegalDocument {
  final String title;
  final String description;
  final String url;

  LegalDocument({
    required this.title,
    required this.description,
    required this.url,
  });

  factory LegalDocument.fromMap(Map<String, dynamic> map) {
    return LegalDocument(
      title: map['title'] ?? 'Sin título',
      description: map['description'] ?? 'Sin descripción',
      url: map['url'] ?? '#',
    );
  }
}

// --- PANTALLA PRINCIPAL ---
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  late Future<List<LegalDocument>> _documentsFuture;
  final Map<String, double> _downloadProgress = {};

  @override
  void initState() {
    super.initState();
    _documentsFuture = _getDocuments();
  }

  void refreshDocuments() {
    setState(() {
      _documentsFuture = _getDocuments();
    });
  }

  Future<List<LegalDocument>> _getDocuments() async {
    try {
      await Future.delayed(const Duration(milliseconds: 700));
      final response = await Supabase.instance.client.from('documentos').select();
      return (response as List<dynamic>)
          .map((map) => LegalDocument.fromMap(map as Map<String, dynamic>))
          .toList();
    } on SocketException {
        throw 'Sin conexión a internet. Por favor, revisa tu conexión e inténtalo de nuevo.';
    } catch (e) {
        throw 'No se pudieron cargar los documentos. Inténtalo más tarde.';
    }
  }

  Future<void> _requestAndDownload(LegalDocument document) async {
    await _downloadFile(document);
  }

  Future<void> _downloadFile(LegalDocument document) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    Directory? dir;

    try {
      if (Platform.isAndroid) {
        dir = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      }

      if (dir == null) {
        throw Exception("Plataforma no soportada o no se pudo obtener el directorio.");
      }

      final fileName = '${document.title.replaceAll(RegExp(r'[\/:*?"<>|]'), '_')}.pdf';
      final savePath = '${dir.path}/$fileName';

      final dio = Dio();
      await dio.download(
        document.url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() => _downloadProgress[document.url] = received / total);
          }
        },
      );
      setState(() => _downloadProgress.remove(document.url));

      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text('Descarga completada en ${dir.path}'),
        action: SnackBarAction(label: 'ABRIR', onPressed: () => OpenFilex.open(savePath)),
      ));
    } on DioException catch (e) {
        setState(() => _downloadProgress.remove(document.url));
        final message = e.type == DioExceptionType.connectionError 
            ? 'Error de conexión. Revisa tu internet.' 
            : 'Error en la descarga: ${e.message}';
        scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      setState(() => _downloadProgress.remove(document.url));
      scaffoldMessenger.showSnackBar(SnackBar(content: Text('Ocurrió un error inesperado.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Documentación Legal')),
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
        child: SafeArea(
          child: FutureBuilder<List<LegalDocument>>(
            future: _documentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('${snapshot.error}', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
                    )
                );
              }
              final documents = snapshot.data ?? [];
              if (documents.isEmpty) {
                return const Center(
                  child: Text('No hay documentos disponibles.'),
                );
              }

              return RefreshIndicator(
                onRefresh: () async => refreshDocuments(),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    return _GlassmorphicCard(
                      document: document,
                      progress: _downloadProgress[document.url],
                      onDownload: () => _requestAndDownload(document),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: (100 * index).ms)
                        .slideY(begin: 0.5);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// --- WIDGET DE TARJETA ---
class _GlassmorphicCard extends StatelessWidget {
  final LegalDocument document;
  final double? progress;
  final VoidCallback onDownload;

  const _GlassmorphicCard({
    required this.document,
    required this.progress,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tilt(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(26),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withAlpha(51)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(document.title, style: theme.textTheme.titleLarge),
                        const SizedBox(height: 8),
                        Text(
                          document.description,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: (progress != null)
                        ? SizedBox(
                            key: const ValueKey('progress'),
                            width: 44,
                            height: 44,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 3,
                              backgroundColor: Colors.white.withAlpha(77),
                              color: theme.colorScheme.secondary,
                            ),
                          )
                        : GestureDetector(
                            key: const ValueKey('button'),
                            onTap: onDownload,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colorScheme.primary.withAlpha(204),
                              ),
                              child: const Icon(
                                Icons.download_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
