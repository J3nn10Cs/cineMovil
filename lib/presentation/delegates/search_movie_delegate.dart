import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//Funcion especifica - PARA BUSQYEDA
typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

//Para realizar la busqueda - Lo que queremos regresar una movie opcional
class SearchMovieDelegate extends SearchDelegate<Movie?>{
  //Funcion para buscar las pelis
  final SearchMovieCallback searchMovies;
  List<Movie> initialMovies;
  //broadcast nuevamente se vuelve a crear el StreamController - se puede usar multiples suscriptores
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  //
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  //DETERMINA UN PERIODO DE TIEMPO, LIMPIARLO Y CANCELARLO
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.initialMovies,
    required this.searchMovies
  });

  void clearStreams(){
    debouncedMovies.close();
  }

  //metodo que va a emitir el valor cuando la persona eja de escribir
  void _onQueryChange(String query) async{
    //cuando escribo se pone en true la busqueda
    isLoadingStream.add(true);
    //si esta activo - es decir cancela lo que la persona escribe
    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    
    //solo se ejecuta cuando se deja de escribir cada 500 milliseconds
    _debounceTimer = Timer(Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

//* Va a ser reutilizable
  Widget buildResultsAndSuggestions(){
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream, 
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

  //cambiar la palabra donde se va a buscar
  @override
  String get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream, 
        builder: (context, snapshot) {
          if(snapshot.data ?? false){
            return SpinPerfect(
              duration: Duration(seconds: 5),
              //para que guire
              spins: 10,
              infinite: true,
              child: IconButton(
                //query => es lo que hemos escrito en la busqueda
                onPressed: () => query = '',
                icon: Icon(
                  Icons.refresh_rounded,
                  color: Colors.black,
                )
              ),
            );
          }
          return FadeIn(
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
          );
        },
      ),
      
      // if(query.isNotEmpty)
        
        

    ];
  }

  //Lo vamos a usar para salir del buscador
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      //metodo que tenemos gracias a SearchDelegate 
      onPressed: () => {
        clearStreams(),
        close(context, null)
      }, 
      icon: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: Colors.black,
      )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChange(query);

    return buildResultsAndSuggestions();
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
      child: GestureDetector(
        onTap: () => context.push('/movie/${movie.id}'),
        child: FadeIn(
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
                    : Text(movie.overview),
                    SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                          SizedBox(width: 3,),
                          Text(HumanFormat.number(movie.voteAverage, 1), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}