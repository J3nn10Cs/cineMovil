import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlidesshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlidesshow({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      //toma todo el ancho posible
      width: double.infinity,
      
      child: Swiper(
        //para que las img de los lados se vea
        viewportFraction: 0.8,
        //para que sean mas pequeños izq and der.
        scale: 0.9,
        //para que se mueva automaticamente
        autoplay: true,
        pagination: SwiperPagination(
          //cambiar la posicion
          margin: EdgeInsets.only(bottom: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          //primero la peli
          return _Slide(movie: movies[index]);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie}); 
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          //difuminado
          blurRadius: 10,
          offset: Offset(1, 10)
        )
      ]
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        //ClipRRect -> Permite colocar bordes redondeados
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            //toma solo el valor que se le está dando
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              //en caso este cargando
              if(loadingProgress != null){
                return DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12)
                );
              }
              //efecto de suavidad
              return FadeIn(child: child);
            },
          )
        )
      ),
    );
  }
}