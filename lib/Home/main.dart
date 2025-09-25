import 'package:flutter/material.dart';
import '../Semestre/principal_semestres.dart';
import '../Profesores/principal_profesores.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduProf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5E60CE)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'EduProf'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF), // Fondo de la app
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          163,
          31,
          31,
        ), // Color del AppBar
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 26, // tamaño de fuente
            fontWeight: FontWeight.bold, // negrita
            color: Colors.white, // color del texto
          ),
        ),
        //centerTitle: true, // centra el título
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header "Bienvenido a EduProf"
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black12),
                ),
                child: const Text(
                  'Bienvenido',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 29, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),

              // Dos cards botón: Semestres / Profesores
              Row(
                children: [
                  Expanded(
                    child: ImageTextButtonCard(
                      imagePath: 'assets/Aji.png',
                      label: 'Semestres',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrincipalSemestres(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ImageTextButtonCard(
                      imagePath: 'assets/Pizza.png',
                      label: 'Profesores',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrincipalProfesores(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Imagen grande "Plan de clases" (solo visual por ahora)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset('assets/Sandia.png', fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card reutilizable (imagen arriba + texto abajo, todo es botón)
class ImageTextButtonCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const ImageTextButtonCard({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                imagePath,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
