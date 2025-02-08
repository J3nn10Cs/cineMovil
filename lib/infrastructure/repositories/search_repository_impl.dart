
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/searchs_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/search_datasource.dart';

class SearchRepositoryImpl extends SearchsRepository {

  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getSearchMovie(String nameMovie) {
    return datasource.getSearchMovie(nameMovie);
  }
  
}