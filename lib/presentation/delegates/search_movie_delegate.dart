import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

//Funcion especifica - PARA BUSQYEDA
typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

//Para realizar la busqueda - Lo que queremos regresar una movie opcional
class SearchMovieDelegate extends SearchDelegate<Movie?>{

  //Funcion para buscar las pelis
  final SearchMovieCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

  //cambiar la palabra donde se va a buscar
  @override
  String get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      
      // if(query.isNotEmpty)
        FadeIn(
          //si el query no esta vacio se muestra la X
          animate: query.isNotEmpty,
          child: IconButton(
            //query => es lo que hemos escrito en la busqueda
            onPressed: () => query = '',
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            )
          ),
        )

    ];
  }

  //Lo vamos a usar para salir del buscador
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      //metodo que tenemos gracias a SearchDelegate 
      onPressed: () => close(context, null), 
      icon: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: Colors.black,
      )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('BuildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query), 
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieSearchItem(movie: movies[index]);
          },
        );
      },
    );
  }
}

class _MovieSearchItem extends StatelessWidget {

  final Movie movie;

  const _MovieSearchItem({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Row(
        children: [
          //*Image
          SizedBox(
            //solo el 20%
            width: size.width * 0.20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
              ),
            ),
          ),

          SizedBox(width: 10,),

          //*Description
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyles.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),

                (movie.overview.length > 100)
                ? Text('${movie.overview.substring(0,100)}...')
                : Text(movie.overview)
              ],
            ),
          )
        ],
      ),
    );
  }
}