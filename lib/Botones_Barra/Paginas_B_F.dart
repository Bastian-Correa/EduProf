import 'package:flutter/material.dart';
import 'package:EduProf/Botones_Barra/Botones_barra_baja.dart';

const _bg = Color(0xFFF0F4FF);
const _bar = Color.fromARGB(255, 163, 31, 31);

class SearchPlaceholderScreen extends StatelessWidget {
  const SearchPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bar,
        title: const Text('Buscar', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text(
          'Buscador próximo para ramos y profesores',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
