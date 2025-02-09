
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider((ref) => '');

final searchedMovieProvider = StateNotifierProvider<SearchedMoviesNotifier,List<Movie>>((ref) {
  final searchRepository = ref.read(searchRepositoryProvider);
  return SearchedMoviesNotifier(
    ref: ref, 
    searchMovies: searchRepository.getSearchMovie
  );
});

typedef SeachMovieCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>>{
  final SeachMovieCallback searchMovies;
  final Ref ref;
  
  SearchedMoviesNotifier({
    required this.ref,
    required this.searchMovies
  }) : super([]);

  //Metodo que regresa la lista de los movies
  Future<List<Movie>> seatchMoviesByQuery(String query) async {

    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    
    return movies;
  }
}