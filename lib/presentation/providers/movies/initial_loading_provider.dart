

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {

  //obtenemos la lista de peliculas 
  final step1 = ref.watch(moviesSlideshowProvider).isEmpty;
  // if(nowPlayingMovies.length == 0) return CircularProgressIndicator();

  //par obtener las peliculas populares
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

  if(step1 || step2 || step3 || step4) return true;

  return false;//terminamos de cargar
},);