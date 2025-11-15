import 'package:flutter/material.dart';
import 'package:EduProf/Base de datos/academico.dart';
import 'package:EduProf/Semestre/ramo_detalle.dart';

class SemestreTab extends StatelessWidget {
  final int ano;
  final int semestre;

  const SemestreTab({super.key, required this.ano, required this.semestre});

  @override
  Widget build(BuildContext context) {
    final index = (ano - 1) * 2 + semestre; // Mapea semestres
    final ramos = ramosPorSemestre[index] ?? [];

    return ramos.isEmpty
        ? const Center(
            child: Text(
              "Próximamente disponible",
              style: TextStyle(color: Colors.black45),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: ramos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final r = ramos[i];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const Icon(Icons.menu_book_rounded),
                  title: Text(r.nombre),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RamoDetalle(ramo: r)),
                  ),
                ),
              );
            },
          );
  }
}
