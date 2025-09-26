import 'package:flutter/material.dart';
import 'package:EduProf/Modelos/profesor.dart';
import 'package:EduProf/Botones_Barra/Botones_barra_baja.dart';

class ProfesorDetalle extends StatelessWidget {
  final Profesor profesor;
  const ProfesorDetalle({super.key, required this.profesor});

  static const fondo = Color(0xFFF0F4FF);
  static const appbarColor = Color.fromARGB(255, 163, 31, 31);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Text(
          profesor.nombre,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Foto grande centrada
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 260,
                height: 340,
                child: (profesor.fotoAsset ?? '').isNotEmpty
                    ? Image.asset(
                        profesor.fotoAsset!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _FotoPlaceholder(),
                      )
                    : _FotoPlaceholder(),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Fila: horario / ubicación
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  title: 'Horario de atención',
                  value: profesor.horario ?? '—',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoTile(
                  title: 'Ubicación de oficina',
                  value: profesor.ubicacion ?? '—',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bibliografía y correo
          _BigBlock(
            title: 'Bibliografía / contacto',
            content: profesor.bioCorreo ?? '—',
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _BigBlock extends StatelessWidget {
  final String title;
  final String content;
  const _BigBlock({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _FotoPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F2F6),
      child: const Center(
        child: Icon(Icons.person_rounded, size: 80, color: Colors.black26),
      ),
    );
  }
}
