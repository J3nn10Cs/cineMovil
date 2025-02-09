import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    //* Rutas padre/hija
    GoRoute(
      //page -> que pagina se quiere mostrar para mantener el estdo
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state){
        //lo obtenemos del path
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        
        //mandamos el numero de la pagina a mostrar
        return HomeScreen(pageIndex: pageIndex,);
      } ,
      routes: [
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
    //para que el path sea '/'
    GoRoute(
      path: '/',
      // _ __ no necesito los argumentos !Redirecciona
      redirect: ( _ , __ ) => '/home/0',
    )
  ]
);