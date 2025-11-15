import 'package:flutter/material.dart';
import 'user_prefs.dart';
import 'package:EduProf/Botones_Barra/botones_barra_baja.dart';
import 'package:EduProf/Acerca/validacion_usuarios.dart';

class AboutScreen extends StatelessWidget {
  final ThemeController controller;
  const AboutScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final seed = controller.seedColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: seed,
        title: const Text(
          'Acerca de EduProf',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EduProf',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Prototipo funcional para facilitar el acceso rápido y organizado a información sobre '
                    'ramos y profesores de la carrera de Ingeniería en Desarrollo de Videojuegos y Realidad Virtual.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desarrollado por',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text('Bastián Correa Díaz'),
                  Text('Estudiante – Universidad de Talca'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contacto',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text('bcorrea23@alumnos.utalca.cl'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Botón para calificar la app
          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ValidacionUsuariosScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: seed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              icon: const Icon(Icons.star_rate_rounded),
              label: const Text(
                'Calificar la app',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
