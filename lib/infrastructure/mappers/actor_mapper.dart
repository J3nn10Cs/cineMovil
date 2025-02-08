import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/creditsdb/cast_castdb.dart';

//Objetivo del mapper tener la conversion de como luce a nuestro Obj personalizado
class ActorMapper {
  
  static Actor castToEntity(CastCastdb castdb) => Actor(
    id: castdb.id, 
    name: castdb.name, 
    profilePath: castdb.profilePath != null 
      ? 'https://image.tmdb.org/t/p/w500//${castdb.profilePath}' 
      : 'https://img.freepik.com/vector-premium/imagen-perfil-avatar-hombre-ilustracion-vectorial_268834-541.jpg?w=360', 
    character: castdb.character
  );
}