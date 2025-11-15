import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:EduProf/Base de datos/academico.dart';
import 'package:EduProf/Modelos/profesor.dart';
import 'profesor_detalle.dart';
import 'package:EduProf/Botones_Barra/Botones_barra_baja.dart';

class PrincipalProfesores extends StatelessWidget {
  const PrincipalProfesores({super.key});

  static const fondo = Color(0xFFF0F4FF);

  /// Agrupa por profesor y acumula los ramos que imparte
  List<_ProfesorConRamos> _buildProfesConRamos() {
    final map = <String, _ProfesorConRamos>{};

    for (final ramo in ramosPorSemestre.values.expand((l) => l)) {
      final prof = ramo.profesorAsignado;
      if (prof == null) continue;

      final id = prof.id;
      final existente = map[id];
      if (existente == null) {
        map[id] = _ProfesorConRamos(profesor: prof, ramos: [ramo.nombre]);
      } else {
        if (existente.ramos.none((r) => r == ramo.nombre)) {
          existente.ramos.add(ramo.nombre);
        }
      }
    }

    final lista = map.values.toList();
    // Ordenamos por nombre de profesor para que se vea ordenado
    lista.sort((a, b) => a.profesor.nombre.compareTo(b.profesor.nombre));
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final profes = _buildProfesConRamos();

    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        title: const Text(
          'Profesores',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: profes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = profes[index];
          return _ProfesorRowCard(
            profesor: item.profesor,
            ramos: item.ramos,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfesorDetalle(profesor: item.profesor),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _ProfesorConRamos {
  final Profesor profesor;
  final List<String> ramos;

  _ProfesorConRamos({required this.profesor, required this.ramos});
}

/// Tarjeta horizontal de profesor
class _ProfesorRowCard extends StatelessWidget {
  final Profesor profesor;
  final List<String> ramos;
  final VoidCallback onTap;

  const _ProfesorRowCard({
    required this.profesor,
    required this.ramos,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foto = profesor.fotoAsset ?? '';
    final seed = Theme.of(context).colorScheme.primary;

    String ramoText;
    if (ramos.isEmpty) {
      ramoText = 'Sin ramo asignado';
    } else if (ramos.length == 1) {
      ramoText = ramos.first;
    } else {
      ramoText = '${ramos.first} · +${ramos.length - 1} ramos más';
    }

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Row(
            children: [
              // foto
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 70,
                  height: 70,
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
              const SizedBox(width: 12),

              // info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profesor.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ramoText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: seed.withOpacity(.8),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            profesor.horario ?? 'Horario no definido',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // indicación de detalle
              const Icon(Icons.chevron_right_rounded, color: Colors.black38),
            ],
          ),
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
          radius: 26,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            iniciales(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
