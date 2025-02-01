
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository {
  //regresa una lista de Movie - Se puede cambiar el origen de datos
  Future<List<Movie>> getNowPlaying({int page = 1});
}