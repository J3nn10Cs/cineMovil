
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

//Llaman la Api y develven datos en bruto
class MoviedbDatasource extends MoviesDatasource {
  //Dio -> gestor de peticiones http
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key' : Environment.theMovieDbKey,
      'language' : 'es-ES'
    }
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    //implementacion para obtener la peliculas
    final response = await dio.get('/movie/now_playing');
    //la data es el json
    //response.data;

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