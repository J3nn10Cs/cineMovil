
import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//permite tener un provider de riverpod donde tiene las instancia para llegar a el
final localStorageProvider = Provider((ref){
  //REGRESAMOS LA INSTANCIA DE LocalStorageRepositoryImpl Y IsarDatasource
  return LocalStorageRepositoryImpl(IsarDatasource());
}); 