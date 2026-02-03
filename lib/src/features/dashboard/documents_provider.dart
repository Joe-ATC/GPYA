import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'document_model.dart';

final documentsProvider = FutureProvider<List<Document>>((ref) async {
  final supabase = Supabase.instance.client;
  
  try {
    final response = await supabase.from('documentos').select();
    
    // IMPRESIÓN DE DEPURACIÓN: Muestra los datos crudos de Supabase en la consola.
    developer.log('Datos recibidos de Supabase: $response', name: 'documentsProvider');

    final documents = (response as List).map((item) => Document.fromJson(item)).toList();
    
    documents.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    return documents;
  } catch (e, stackTrace) {
    developer.log(
      'Error fetching documents',
      name: 'documentsProvider',
      error: e,
      stackTrace: stackTrace,
    );
    throw Exception('No se pudieron cargar los documents. Error: ${e.toString()}');
  }
});
