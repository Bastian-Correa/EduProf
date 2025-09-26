import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:EduProf/Base de datos/academico.dart';
import 'package:EduProf/Modelos/profesor.dart';
import 'profesor_detalle.dart';
import 'package:EduProf/Botones_Barra/Botones_barra_baja.dart';

class PrincipalProfesores extends StatelessWidget {
  const PrincipalProfesores({super.key});

  static const fondo = Color(0xFFF0F4FF);
  static const appbarColor = Color.fromARGB(255, 163, 31, 31);

  //Lista de Profesores (sin duplicados por id)
  Map<String, List<Profesor>> _buildProfesPorRamo() {
    final map = <String, List<Profesor>>{};
    ramosPorSemestre.values.expand((l) => l).forEach((ramo) {
      final prof = ramo.profesorAsignado;
      if (prof == null) return;
      final list = map.putIfAbsent(ramo.nombre, () => []);
      if (list.none((p) => p.id == prof.id)) list.add(prof);
    });
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final data = _buildProfesPorRamo();
    final entries = data.entries.toList();

    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: const Text(
          'Profesores',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final ramo = entries[index].key;
          final lista = entries[index].value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: Text(
                  ramo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lista.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, i) {
                  final p = lista[i];
                  return _ProfesorCard(
                    profesor: p,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfesorDetalle(profesor: p),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _ProfesorCard extends StatelessWidget {
  final Profesor profesor;
  final VoidCallback onTap;
  const _ProfesorCard({required this.profesor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final foto = profesor.fotoAsset ?? '';
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: foto.isNotEmpty
                    ? Image.asset(
                        foto,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _PlaceholderFoto(nombre: profesor.nombre),
                      )
                    : _PlaceholderFoto(nombre: profesor.nombre),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                profesor.nombre,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderFoto extends StatelessWidget {
  final String nombre;
  const _PlaceholderFoto({required this.nombre});

  @override
  Widget build(BuildContext context) {
    String iniciales() {
      final partes = nombre.trim().split(RegExp(r'\s+'));
      final letras = partes
          .take(2)
          .map((p) => p.characters.first.toUpperCase());
      return letras.join();
    }

    return Container(
      color: const Color(0xFFF1F2F6),
      child: Center(
        child: CircleAvatar(
          radius: 34,
          backgroundColor: const Color(0xFF5E60CE),
          child: Text(
            iniciales(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
