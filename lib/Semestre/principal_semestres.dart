import 'package:flutter/material.dart';
import 'package:EduProf/Semestre/ano_detalle.dart';
import 'package:EduProf/Botones_Barra/Botones_barra_baja.dart';

class PrincipalSemestres extends StatelessWidget {
  const PrincipalSemestres({super.key});

  static const fondo = Color(0xFFF0F4FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        title: const Text(
          'Semestres',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, i) {
          final ano = i + 1;
          return _AnoCard(
            ano: ano,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AnoDetalleScreen(ano: ano)),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _AnoCard extends StatelessWidget {
  final int ano;
  final VoidCallback onTap;
  const _AnoCard({required this.ano, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 18,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(
          Icons.school_rounded,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Año $ano',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Colors.black38,
        ),
        onTap: onTap,
      ),
    );
  }
}
