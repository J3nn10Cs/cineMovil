import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String,List<Actor>>>((ref){

  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});

// lo vamos a guardar en un map en caso no exista y si existe solo se llama
//* {
/*
  '504607': List<Actor>,
  '504623': List<Actor>,
  '504612': List<Actor>,
  '504643': List<Actor>,
*/
//* } */

typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>>{
  final GetActorsCallback getActors;
  ActorsByMovieNotifier({required this.getActors}): super({});

  Future<void> loadActors( String movieId ) async {
    //si ya tiene una peli con ese id y es diferente de null
    if(state[movieId] != null) return;
    final List<Actor> actors = await getActors(movieId);
    //actualizacion de nuestro estado
    state = {...state,movieId : actors};
  }

}