import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int selectedIndex = 0;

  void onItemTapped(BuildContext context, int index){

    // Actualizar el índice seleccionado
    setState(() {
      selectedIndex = index; 
    });

    switch(index){
      case 0 :
        context.go('/');
        break;
      case 1 :
        context.go('/categories');
        break;
      case 2 :
        context.go('/favorites');
        break;
      case 3 :
        context.go('/setting');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //para evitar el cambio de tamaño
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blueAccent,
      elevation: 1,
      //donde vamos a navegar -> 0 1 2 3
      onTap: (value) => onItemTapped(context, value),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Category'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorite'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Setting'
        ),
      ],
    );
  }
}