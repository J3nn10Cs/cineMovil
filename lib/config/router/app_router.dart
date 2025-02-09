import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    ShellRoute(
      //se llama en tiempo de ejecucion para construir algo
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return HomeView();
          },
          routes: [
            //Para poder entrar  auna pelicula en particular
            GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                //obtener el id
                final movieId = state.pathParameters['id'] ?? 'no-id';

                return MovieScreen(movieId: movieId);
              },
            ),
          ]
        ),
        GoRoute(
          path: '/categories',
          builder: (context, state) {
            return CategoryView();
          },
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return FavoritesView();
          },
        ),
        GoRoute(
          path: '/setting',
          builder: (context, state) {
            return SettingView();
          },
        ),
      ]
    ),

    //* Rutas padre/hija
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => HomeScreen(childView: HomeView()),
    //   routes: [
        // GoRoute(
        //   path: 'movie/:id',
        //   name: MovieScreen.name,
        //   builder: (context, state) {
        //     //obtener el id
        //     final movieId = state.pathParameters['id'] ?? 'no-id';

        //     return MovieScreen(movieId: movieId);
        //   },
        // ),
    //   ]
    // ),
  ]
);