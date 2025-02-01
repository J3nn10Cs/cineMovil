
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  //variables de entorno static
  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay Api Key';
}