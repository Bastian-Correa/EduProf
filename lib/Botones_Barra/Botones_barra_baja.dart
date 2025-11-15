import 'package:flutter/material.dart';
import 'package:EduProf/Home/main.dart';
import 'package:EduProf/Botones_Barra/search_screen.dart';
import 'package:EduProf/Botones_Barra/favoritos_screen.dart';
import 'package:EduProf/Home/home.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  void _goHome(BuildContext context) {
    final myApp = context.findAncestorWidgetOfExactType<MyApp>();
    final themeCtrl = myApp?.themeCtrl;

    if (themeCtrl != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => MyHomePage(title: 'EduProf', themeCtrl: themeCtrl),
        ),
        (r) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Placeholder()),
        (r) => false,
      );
    }
  }

  void _goSearch(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
  }

  void _goFavoritos(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const FavoritosScreen(initialTab: FavoritosTab.ramos),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black87,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (i) {
        switch (i) {
          case 0:
            _goHome(context);
            break;
          case 1:
            _goSearch(context);
            break;
          case 2:
            _goFavoritos(context);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_rounded),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
