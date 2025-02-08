import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

//para que el provider pueda tomar esta impl - sirve de puente con los gestores de estado
class ActorRespositoryImpl extends ActorsRepository {
  final ActorsDatasource actorDatasource;
  ActorRespositoryImpl(this.actorDatasource);
  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return actorDatasource.getActorsByMovie(movieId);
  }
  
}