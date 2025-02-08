
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provedor de notificacion cuando cambia el estado y maneja una lista de peliculas
final nowPlayinMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //watch (escuchar) movieRepositoryProvider -> obtiene los datos de una Api
  //getNowPlaying -> obtiene las peliculas en cartelera
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
},);

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getPopular;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
},);

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getUpcoming;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
},);

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
},);

//para poder llamarlo sin importar de donde vienen los datos
typedef MovieCallback = Future<List<Movie>> Function({int page});

//Se va a manejar una lista de peliculas
class MoviesNotifier extends StateNotifier<List<Movie>> {
  //saber la pagina actual
  int currentPage = 0;
  bool isLoading = false;
  //funcion para obtener mas peliculas
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies
    //El estado inicial es una lista vacía de películas
  }): super([]);

  //
  Future<void> loadNextPage() async{
    //Si isLoading es true, la función termina (return) para evitar llamadas repetidas
    if(isLoading) return;
    //indicar que la carga de datos está en proceso
    isLoading = true;
    //para obtener la siguiente pagina
    currentPage++;
    //obtiene la siguiente tanda de películas
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    //agrega las nuevas peliculas a la lista ya existente
    state = [...state,...movies];
    //Agrega una pequeña pausa de 300 microsegundos antes de permitir otra carga
    await Future.delayed(Duration(microseconds: 300));
    //Una vez que las películas han sido agregadas a state, marca la carga como terminada (isLoading = false)
    isLoading = false;
  }
}