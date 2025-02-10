import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

//Funcionalidades especificas para manejar el almacenamiento local de las peliculas
class IsarDatasource extends LocalStorageDatasource {
  //evitar inicializacion inmediata
  late Future<Isar> db;

  //constructor
  IsarDatasource(){
    //se ejecuta inmediatamente para inicializar
    db = openDB();
  }

  Future<Isar> openDB() async{
    //ruta de directorio de caché
    final dir = await getApplicationCacheDirectory();
    
    //verifica si la BD no está abierta
    if(Isar.instanceNames.isEmpty){
      //ABRIR LA BD
      return await Isar.open(
        //le pasamos el schema estructura de la tablas
        [MovieSchema], 
        //direcion del caché
        directory: dir.path,
        //permite inspeccionar la Bd en modo desarrollo
        inspector: true
      );
    }
    //Si ya está abierta, devuelve la instancia existente
    return Future.value(Isar.getInstance());
  }

  @override
  //metodo asincrono 
  Future<bool> isMovieFavorite(int movieId) async {
    //
    final isar = await db;
    
    final Movie? isFavoriteMovie = await isar.movies
      //filtra pelicula
      .filter()
      //busca pelicula por ID
      .idEqualTo(movieId)
      //devuelve el primer registo 
      .findFirst();
    
    //si es null regresa false, si no true
    return isFavoriteMovie != null;
  }

  @override
  //metodo para agregar o quitar pelicula de favoritas
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies
        //filtra pelicula
        .filter()
        //busca pelicula por ID
        .idEqualTo(movie.id)
        //devuelve el primer registo
        .findFirst();
    
    //verificamos si existe
    if(favoriteMovie != null){
      //transaccion sincrona para ecribir en la bd - elimina la pelicula segun su Id
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!) );
      return;
    }

    //imsertamos
    isar.writeTxnSync(() => isar.movies.putSync(movie) );
  }
  
  @override
  //metodo que retorna una lista de peliculas
    //limit = 10: -> máximo número de películas a devolver (10)
    //offset = 0 -> número de registros a saltar antes de empezar a devolver los resultados
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    //
    final isar = await db;
    
    //hacer un filtro donde
    return isar.movies.where()
        //omite los primeros offset es decir 0 peliculas
        .offset(offset)
        //y su numero limite a devoler es 10
        .limit(limit)
        //ejecuta la consulta y devulve los resultados que cumplan los dos anteriores criterios
        .findAll();
  }
}