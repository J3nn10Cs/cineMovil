import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {

  final int indexPage;

  const CustomBottomNavigation({super.key, required this.indexPage});

  void onItemTapped(BuildContext context, int index){
    
    switch(index){
      case 0 :
        context.go('/home/0');
        break;
      case 1 :
        context.go('/home/1');
        break;
      case 2 :
        context.go('/home/2');
        break;
      case 3 :
        context.go('/home/3');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //para evitar el cambio de tamaño
      type: BottomNavigationBarType.fixed,
      currentIndex: indexPage,
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