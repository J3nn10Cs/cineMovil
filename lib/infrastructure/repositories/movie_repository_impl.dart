//Llamar el datasource y sus metodos
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

//podemos llamar el metodo basado en el datasource
class MovieRepositoryImpl extends MoviesRepository {
  //fuente de datos publicas
  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  @override
  //retorna una lista de peliculas en cartelera
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    //aqui se van a obtener los datos
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  //retorna una lista de peliculas que obtiene peliculas populares
  Future<List<Movie>> getPopular({int page = 1}) {
    //aqui se van a obtener los datos
    return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page : page);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }
  
  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
}