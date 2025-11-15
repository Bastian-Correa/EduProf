import 'package:flutter/material.dart';
import 'package:EduProf/Modelos/ramo.dart';
import 'package:EduProf/Semestre/ramo_detalle.dart';
import 'package:EduProf/Botones_Barra/Botones_barra_baja.dart';

class SemestreDetalle extends StatelessWidget {
  final int semestre;
  final List<Ramo> ramos;

  const SemestreDetalle({
    super.key,
    required this.semestre,
    required this.ramos,
  });

  static const fondo = Color(0xFFF0F4FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Semestre $semestre'),
      ),
      body: ListView.separated(
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: const Icon(
                Icons.menu_book_rounded,
                color: Colors.black54,
              ),
              title: Text(
                r.nombre,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black38,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RamoDetalle(ramo: r)),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
