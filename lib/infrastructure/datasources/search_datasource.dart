
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/search_movie_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

//Busqueda
class SearchDatasource extends SearchMovieDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key' : Environment.theMovieDbKey,
      'language' : 'es-ES'
    }
  ));

  @override
  Future<List<Movie>> getSearchMovie(String nameMovie) async {

    if(nameMovie.isEmpty) return [];

    //implementacion para obtener la peliculas
    final response = await dio.get('/search/movie',
      queryParameters: {
        'query' : nameMovie
      }
    );

    //resivimos el json
    final movieDBResponse = MoviedbResponse.fromJson(response.data);
    //para tener el listado de movie - trnsformamos el response a Movie
    final List<Movie> movies = movieDBResponse.results
      //hacemos un filtro para poder pasar al map
      .where((moviedb) => moviedb.posterPath != 'no-poster' ,)
      .map((moviedb) => MovieMapper.movieDbToEntity(moviedb)
      ).toList();
    
    return movies;
  }
  
}