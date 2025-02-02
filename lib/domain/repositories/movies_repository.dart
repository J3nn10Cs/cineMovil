
import 'package:cinemapedia/domain/entities/movie.dart';

//REPOSITORIES -> Contiene interfaces de repositorios, que son contratos que otras capas deben implementar para acceder a los datos
abstract class MoviesRepository {
  //regresa una lista de Movie - Se puede cambiar el origen de datos - metodo asincrono
  Future<List<Movie>> getNowPlaying({int page = 1});
}