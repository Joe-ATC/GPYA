enum DocumentCategory {
  contratos,
  demandas,
  identificaciones,
}

// Función para convertir un string a DocumentCategory
DocumentCategory categoryFromString(String? categoryString) {
  if (categoryString == null) {
    return DocumentCategory.contratos; // O un valor por defecto que prefieras
  }
  switch (categoryString.toLowerCase()) {
    case 'contratos':
      return DocumentCategory.contratos;
    case 'demandas':
      return DocumentCategory.demandas;
    case 'identificaciones':
      return DocumentCategory.identificaciones;
    default:
      return DocumentCategory.contratos; // O lanzar un error
  }
}

// Extensión para obtener el nombre del icono
extension DocumentCategoryExtension on DocumentCategory {
  String get iconName {
    switch (this) {
      case DocumentCategory.contratos:
        return 'Contrato';
      case DocumentCategory.demandas:
        return 'Demanda';
      case DocumentCategory.identificaciones:
        return 'ID';
    }
  }
}

class Document {
  final String id;
  final String title;
  final String description;
  final String fileUrl;
  final String? thumbnailUrl;
  final DateTime createdAt;
  final DocumentCategory category; // Campo añadido
  final String downloadUrl; // Campo añadido

  Document({
    required this.id,
    required this.title,
    required this.description,
    required this.fileUrl,
    this.thumbnailUrl,
    required this.createdAt,
    required this.category,
    required this.downloadUrl,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      // CORRECCIÓN: Se convierte el ID a String de forma segura para evitar errores de tipo.
      id: json['id'].toString(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      fileUrl: json['url'] as String? ?? '',
      thumbnailUrl: json['thumbnail_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      // Conversión segura del string de la DB a nuestro enum
      category: categoryFromString(json['category'] as String?),
      // Aseguramos que downloadUrl no sea nulo
      downloadUrl: json['download_url'] as String? ?? json['url'] as String? ?? '',
    );
  }
}
