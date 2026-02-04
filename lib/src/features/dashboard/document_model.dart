enum DocumentCategory {
  seguridad,
  salud,
  organizacion,
  especificas,
}

// Función para convertir un string a DocumentCategory
DocumentCategory categoryFromString(String? categoryString) {
  if (categoryString == null) {
    return DocumentCategory.seguridad; // Valor por defecto
  }
  switch (categoryString.toLowerCase()) {
    case 'seguridad':
      return DocumentCategory.seguridad;
    case 'salud':
      return DocumentCategory.salud;
    case 'organizacion':
      return DocumentCategory.organizacion;
    case 'especificas':
      return DocumentCategory.especificas;
    default:
      return DocumentCategory.seguridad;
  }
}

// Extensión para obtener propiedades de cada categoría
extension DocumentCategoryExtension on DocumentCategory {
  String get displayName {
    switch (this) {
      case DocumentCategory.seguridad:
        return 'Normas de Seguridad';
      case DocumentCategory.salud:
        return 'Normas de Salud';
      case DocumentCategory.organizacion:
        return 'Normas de Organización';
      case DocumentCategory.especificas:
        return 'Normas Específicas';
    }
  }

  String get shortName {
    switch (this) {
      case DocumentCategory.seguridad:
        return 'Seguridad';
      case DocumentCategory.salud:
        return 'Salud';
      case DocumentCategory.organizacion:
        return 'Organización';
      case DocumentCategory.especificas:
        return 'Específicas';
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
  final DocumentCategory category;
  final String downloadUrl;

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
      id: json['id'].toString(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      fileUrl: json['url'] as String? ?? '',
      thumbnailUrl: json['thumbnail_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      category: categoryFromString(json['category'] as String?),
      downloadUrl: json['download_url'] as String? ?? json['url'] as String? ?? '',
    );
  }
}
