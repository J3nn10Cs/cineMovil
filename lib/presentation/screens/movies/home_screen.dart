
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widget.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  //index de la pagina a mostrar
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});
  
  //Listado de los routes - para mantener el estado
  final viewRoutes = const <Widget>[
    HomeView(),
    CategoryView(),
    FavoritesView(),
    SettingView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Widget para perservar/!controlar el estado
      body: IndexedStack(
        //el index es pageIndex
        index: pageIndex,
        //coleccion de widgets para cambiar dependiendo el pageIndex
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(indexPage: pageIndex ,)
    );
  }
}

