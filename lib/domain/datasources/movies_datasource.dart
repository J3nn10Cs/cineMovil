import 'package:cinemapedia/domain/entities/movie.dart';

//Definimos la fuente de datos abstracta, y el colo obtener las peliculas
abstract class MoviesDatasource {
  
  Future <List<Movie>> getNowPlaying({int page = 1});
}