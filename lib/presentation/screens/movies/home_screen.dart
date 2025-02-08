import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation()
    );
  }
}

//Puede cambiar de estado
class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  //se ejecuta una vez al iniciar la pantalla
  void initState() {
    super.initState();
    ref.read( nowPlayinMoviesProvider.notifier ).loadNextPage();
    ref.read( popularMoviesProvider.notifier ).loadNextPage();
    ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
    ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return FullScreenLoader();

    //renderizamos la data
    final slidesShowMovies = ref.watch(nowPlayinMoviesProvider);

    //obtenemos la lista de peliculas 
    final nowMoviePlaying = ref.watch(moviesSlideshowProvider);
    // if(nowPlayingMovies.length == 0) return CircularProgressIndicator();

    //par obtener las peliculas populares
    final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: CustomsAppbar(),
          
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlidesshow(movies: nowMoviePlaying,),
                  //las 20 peliculas en cartelera
                  MovieHorizontalListview(
                    movies: slidesShowMovies,
                    title: 'En cines',
                    subtitle: 'Lunea 20',
                    loadNextPage: () => ref.read(nowPlayinMoviesProvider.notifier).loadNextPage(),
                  ),
                  //las 20 peliculas en cartelera
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Proximamente',
                    // subtitle: 'Este mes',
                    loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: upComingMovies,
                    title: 'Populares',
                    // subtitle: 'Lunea 20',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificada',
                    subtitle: 'Desde siempre',
                    loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  ),
                  //Para que haya un poco mas de espacio luego
                  //SizedBox(height: 20,)
                ],
              );
            },
            childCount: 1
          )
        )
      ],
    );
  }
}