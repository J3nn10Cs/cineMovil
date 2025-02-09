import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class MovieHorizontalListview extends StatefulWidget {
  //argumentos que se van a necesitar
  final List<Movie> movies;
  final String? title ;
  final String? subtitle ;
  //para poder cargar las siguientes peliculas
  final VoidCallback? loadNextPage;
  const MovieHorizontalListview({super.key, this.title, this.subtitle, required this.movies, this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();
  @override
  //se usa para inicializar variables, controladores o suscribirse a evento
  void initState() {
    super.initState();
    scrollController.addListener((){
      if( widget.loadNextPage == null ) return;

      //pixel representa a la posicion actual de la pantalla es mayor hasta donde puede desplazarse el usuario
      if( (scrollController .position.pixels + 200) >= scrollController.position.maxScrollExtent){
        // !-> pq puede ser null
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    //* Para hacer limpieza
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      //para poder colocar los dos de arriba, centro y abajo
      child: Column(
        children: [
          //en caso no hay ni sub ni title no lo renderizamos pero, si son diferentes de null si
          if(widget.title != null || widget.subtitle != null)
            //* Widget del titulo
            _Title(title: widget.title,subtitle: widget.subtitle,),
          Expanded(
            child: ListView.builder(
              //lo asociamos al controller el scrollController
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            )
          )
        ],
      ),
    );
  }
}

//MOSTRAR LAS PELICULAS
class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //**Imagen */
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 2/3,
                child: Image.network(
                  //para que todas tengan el mismo espacio
                  movie.posterPath,
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                  loadingBuilder: (context, child, loadingProgress) {
                    if(loadingProgress != null){
                      return Center(child: CircularProgressIndicator());
                    }
                    return GestureDetector(
                      //para poder regresar
                      onTap: () => context.push('/movie/${movie.id}'),
                      child: FadeIn(child: child),
                    );
                  },

                ),
              )
            ),
          ),

          //**Title */
          SizedBox(
            width: 150,
            child: Text(
              movie.title, 
              style: textStyles.bodySmall,
              maxLines: 2,
            ),
          ),
          //* Rating
          //para poder agregarle un spacer
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                SizedBox(width: 3,),
                Text(HumanFormat.number(movie.voteAverage,1), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
                Spacer(),
                Text(HumanFormat.number(movie.popularity, 1), style: textStyles.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//Mostrar UN TEXTO
class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          if(title != null)
            Text(title!, style: titleStyle,),
          //igual al flex spacebetwen
          Spacer(),

          if(subtitle != null)
            FilledButton.tonal(
              //para que el boton sea mas pequeño
              style: ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: (){},
              child: Text(subtitle!),
            )

        ],
      ),
    );
  }
}