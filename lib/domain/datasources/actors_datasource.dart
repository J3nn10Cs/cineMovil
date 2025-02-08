import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsDatasource {
  //definimos las reglas que vamos a necesitar

  Future<List<Actor>> getActorsByMovie (String movieId);
}