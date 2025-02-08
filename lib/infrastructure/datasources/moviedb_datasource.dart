
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
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

  List<Movie> _jsonToMovies(Map<String,dynamic> json){
    //resivimos el json
    final movieDBResponse = MoviedbResponse.fromJson(json);
    //para tener el listado de movie - trnsformamos el response a Movie
    final List<Movie> movies = movieDBResponse.results
      //hacemos un filtro para poder pasar al map
      .where((moviedb) => moviedb.posterPath != 'no-poster' ,)
      .map((moviedb) => MovieMapper.movieDbToEntity(moviedb)
      ).toList();
    
    return movies;
  }

  //nuevas peliculas
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    //implementacion para obtener la peliculas
    final response = await dio.get('/movie/now_playing',
      queryParameters: {
        'page' : page
      }
    );
    //la data es el json
    //response.data;
    return _jsonToMovies(response.data);
    
  }
  
  //peliculas populares
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    //implementacion para obtener la peliculas
    final response = await dio.get('/movie/popular',
      queryParameters: {
        'page' : page
      }
    );
    
    return _jsonToMovies(response.data);
  }
  
  //
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    //implementacion para obtener la peliculas
    final response = await dio.get('/movie/top_rated',
      queryParameters: {
        'page' : page
      }
    );
    
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    //implementacion para obtener la peliculas
    final response = await dio.get('/movie/upcoming',
      queryParameters: {
        'page' : page
      }
    );
    
    return _jsonToMovies(response.data);
  }
  
  //implementacion del metodo getMovieById
  @override
  Future <Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    //si salio mal
    if(response.statusCode != 200) throw Exception('Movie with id $id not found');

    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }
  
}