import 'package:flutter/material.dart';
import 'package:EduProf/Modelos/ramo.dart';
import 'package:EduProf/Profesores/profesor_detalle.dart';
import 'package:EduProf/Botones_Barra/Botones_barra_baja.dart';

class RamoDetalle extends StatelessWidget {
  final Ramo ramo;
  const RamoDetalle({super.key, required this.ramo});

  static const fondo = Color(0xFFF0F4FF);
  static const appbarColor = Color.fromARGB(255, 163, 31, 31);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Text(
          ramo.nombre,
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
          _panel(
            title: 'De qué trata',
            child: Text(ramo.descripcion, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _panel(
                  title: 'Créditos',
                  child: Text(
                    '${ramo.creditos}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'Requiere',
                  child: Text(
                    ramo.requisitosIds.isEmpty
                        ? '—'
                        : ramo.requisitosIds.join(', '),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Profesor asignado',
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                final p = ramo.profesorAsignado;
                if (p == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Aún sin profesor asignado')),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfesorDetalle(profesor: p),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Row(
                  children: [
                    _profFoto(ramo),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        ramo.profesorAsignado?.nombre ?? 'Por asignar',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }

  Widget _panel({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _profFoto(Ramo r) {
    final asset = r.profesorAsignado?.fotoAsset;
    if (asset == null || asset.isEmpty) {
      return const CircleAvatar(radius: 28, child: Icon(Icons.person));
    }
    return CircleAvatar(
      radius: 28,
      backgroundImage: AssetImage(asset),
      onBackgroundImageError: (_, __) {},
    );
  }
}
