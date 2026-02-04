import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/src/features/dashboard/document_model.dart';
import 'package:myapp/src/features/dashboard/documents_provider.dart';

/// Provider para el texto de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Provider para la categoría seleccionada (null = mostrar todas)
final selectedCategoryProvider = StateProvider<DocumentCategory?>((ref) => null);

/// Provider que filtra los documentos según búsqueda y categoría
final filteredDocumentsProvider = Provider<AsyncValue<List<Document>>>((ref) {
  final documentsAsync = ref.watch(documentsProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase().trim();
  final selectedCategory = ref.watch(selectedCategoryProvider);

  return documentsAsync.whenData((documents) {
    return documents.where((doc) {
      // Filtro por categoría
      final matchesCategory = selectedCategory == null || doc.category == selectedCategory;
      
      // Filtro por búsqueda (título o descripción)
      final matchesSearch = searchQuery.isEmpty ||
          doc.title.toLowerCase().contains(searchQuery) ||
          doc.description.toLowerCase().contains(searchQuery);
      
      return matchesCategory && matchesSearch;
    }).toList();
  });
});
