

import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDatasource {

  //para guardar a favoriitos - Mandamos la pelicula
  Future<void> toggleFavorite(Movie movie);
  
  Future<bool> isMovieFavorite(int movieId);

  //para hacer la paginacion de 10 en 10
  Future<List<Movie>> loadMovies( {int limit=10, offset=0} );

}