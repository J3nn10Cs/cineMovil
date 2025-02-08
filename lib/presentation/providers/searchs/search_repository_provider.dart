
import 'package:cinemapedia/infrastructure/datasources/search_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/search_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRepositoryProvider = Provider((ref) {
  return SearchRepositoryImpl(SearchDatasource());
});