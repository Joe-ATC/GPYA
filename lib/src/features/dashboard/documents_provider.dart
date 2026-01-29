import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'document_model.dart';

final documentsProvider = FutureProvider<List<Document>>((ref) async {
  final supabase = Supabase.instance.client;
  
  try {
    final response = await supabase.from('documents').select();
    
    final documents = (response as List).map((item) => Document.fromJson(item)).toList();
    
    // Ordenar documentos por fecha de creación (los más nuevos primero)
    documents.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    return documents;
  } catch (e, stackTrace) {
    developer.log(
      'Error fetching documents',
      name: 'documentsProvider',
      error: e,
      stackTrace: stackTrace,
    );
    throw Exception('No se pudieron cargar los documentos. Inténtelo de nuevo.');
  }
});
