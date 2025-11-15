import 'package:flutter/material.dart';
import 'package:EduProf/Botones_Barra/search_screen.dart';

class SearchPlaceholderScreen extends StatelessWidget {
  const SearchPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Redirige a la pantalla real de búsqueda.
    return const SearchScreen();
  }
}
