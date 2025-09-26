import 'package:flutter/material.dart';
import 'package:EduProf/Home/main.dart';
import 'package:EduProf/botones_barra/paginas_b_f.dart';

class AppBottomNav extends StatelessWidget {
  /// 0 = Inicio, 1 = Buscar, 2 = Favoritos
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  void _goHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MyHomePage(title: 'EduProf')),
      (r) => false,
    );
  }

  void _goSearch(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SearchPlaceholderScreen()));
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
      ],
    );
  }
}
