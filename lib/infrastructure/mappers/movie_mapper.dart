// Lo que va a hacer el mappes es leer diferentes modelos y crear la entidad
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

//Convierte datos de la API a objetos de la app
class MovieMapper {
  //vamos a crear una pelicula basado en algun tipo de objeto
  static Movie movieDbToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      // si el path es diferente a vacio se le agrega una img si no, found 404  
      backdropPath: moviedb.backdropPath != '' ? 'https://image.tmdb.org/t/p/w500//${moviedb.backdropPath}' 
      :'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(), 
      id: moviedb.id, 
      originalLanguage: moviedb.originalLanguage, 
      originalTitle: moviedb.originalTitle, 
      overview: moviedb.overview, 
      popularity: moviedb.popularity, 
      posterPath: moviedb.posterPath != '' 
        ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}' 
        : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg' , 
      releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(), 
      title: moviedb.title, 
      video: moviedb.video, 
      voteAverage: moviedb.voteAverage, 
      voteCount: moviedb.voteCount
    );

    //Para los detalles
    static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
      adult: movie.adult, 
      // si el path es diferente a vacio se le agrega una img si no, found 404  
      backdropPath: movie.backdropPath != '' ? 'https://image.tmdb.org/t/p/w500//${movie.backdropPath}' 
      :'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
      //solo requerimos el name del genero
      genreIds: movie.genres.map((e) => e.name).toList(), 
      id: movie.id, 
      originalLanguage: movie.originalLanguage, 
      originalTitle: movie.originalTitle, 
      overview: movie.overview, 
      popularity: movie.popularity, 
      posterPath: movie.posterPath != '' 
        ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}' 
        : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg' , 
      releaseDate: movie.releaseDate, 
      title: movie.title, 
      video: movie.video, 
      voteAverage: movie.voteAverage, 
      voteCount: movie.voteCount
    );
}