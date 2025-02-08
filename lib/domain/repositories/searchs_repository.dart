
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class SearchsRepository {
  Future <List<Movie>> getSearchMovie(String nameMovie);
}