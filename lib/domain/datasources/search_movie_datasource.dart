
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class SearchMovieDatasource {
  Future <List<Movie>> getSearchMovie(String nameMovie);
}