import 'package:flutter/material.dart';
import 'package:EduProf/Acerca/validacion_usuarios.dart';

class AcercaDeScreen extends StatelessWidget {
  const AcercaDeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de EduProf'),
        backgroundColor: seed,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'EduProf\n\nAquí va la descripción de tu aplicación, versión, '
            'créditos, etc...',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 32),

          // Botón de calificación
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
    );
  }
}
