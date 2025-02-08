import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_details_info_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-home';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}


class MovieScreenState extends ConsumerState <MovieScreen> {
  //los widgets solo llaman providers
  @override
  void initState() {
    super.initState();
    //vamos a hacer la peticion solo una vez
    ref.read(movieDetailsInfoProvide.notifier).loadMovieDetails(widget.movieId);
    ref.read(actorByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {

    //quiero que en el mapa busque el elemento
    final Movie? movie = ref.watch(movieDetailsInfoProvide)[widget.movieId];

    if(movie == null){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      //para poder trabajar con los slivers
      body: CustomScrollView(
        //para que no haya rebote
        physics: ClampingScrollPhysics(),
        slivers: [
          //*imagenes
          _CustomSliverAppBar(movie: movie,),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              //*Detalles
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1
            ),
          )
        ],
      ),
    );
  }
}

//*Detalles
class _MovieDetails extends StatelessWidget {
  
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //para cortar los bordes redondeados - Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              SizedBox(width: 10,),

              //* Descripcion
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyles.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(movie.overview)
                  ],
                ),
              ),
            ],
          ),
        ),
        //*Generos de peliculas
        Padding(
          //separacion de 8
          padding: EdgeInsets.all(8),
          //
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ))
            ],
          ),
        ),

        _ActorByMovie(movieId: movie.id.toString(),),

        SizedBox(height: 20,)
      ],
    );
  }
}

//*Actores
class _ActorByMovie extends ConsumerWidget {

  final String movieId;
  const _ActorByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {

    final actorsByMovie = ref.watch(actorByMovieProvider);

    if(actorsByMovie[movieId] == null){
      return CircularProgressIndicator();
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          //posicion
          final actor = actors[index];

          return FadeInRight(
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
            
                  SizedBox(height: 8,),
                  //2 linea maximo
                  Text(actor.name,maxLines: 2,),
                  //
                  Text(
                    actor.character ?? '', 
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//* Imagen
class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      //70% del dispositivo
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      //espacio flexible del custom
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  //si es diferente de null
                  if(loadingProgress != null) return SizedBox();

                  //regresamos la imagen
                  return FadeIn(child: child);
                },
              ),
            ),

            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7,1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black87
                    ]
                  )
                ),
              ),
            ),

            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0,0.4],
                    colors: [
                      Colors.black87,
                      Colors.transparent
                    ]
                  )
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}