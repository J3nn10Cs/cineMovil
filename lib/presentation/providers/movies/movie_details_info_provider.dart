import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsInfoProvide = StateNotifierProvider<MovieMapNotifier, Map<String,Movie>>((ref){

  final movieRepository = ref.watch(movieRepositoryProvider).getMovieById;

  return MovieMapNotifier(getMovie: movieRepository);
});

// lo vamos a guardar en un map en caso no exista y si existe solo se llama
//* {
/*
  '504607': Movie(),
  '504623': Movie(),
  '504612': Movie(),
  '504643': Movie(),
*/
//* } */

typedef GetMovieCallback = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>>{
  final GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie}): super({});

  Future<void> loadMovieDetails( String movieId ) async {
    //si ya tiene una peli con ese id y es diferente de null
    if(state[movieId] != null) return;
    final movie = await getMovie(movieId);
    //actualizacion de nuestro estado
    state = {...state,movieId : movie};
  }

}