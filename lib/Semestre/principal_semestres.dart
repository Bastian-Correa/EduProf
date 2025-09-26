import 'package:flutter/material.dart';
import 'package:EduProf/Base de datos/academico.dart';
import 'package:EduProf/Semestre/semestre_detalles.dart';
import 'package:EduProf/Botones_Barra/Botones_barra_baja.dart';

class PrincipalSemestres extends StatelessWidget {
  const PrincipalSemestres({super.key});

  static const fondo = Color(0xFFF0F4FF);
  static const appbarColor = Color.fromARGB(255, 163, 31, 31);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: const Text(
          'Semestres',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final semestre = index + 1;
            final lista = ramosPorSemestre[semestre];
            final enabled = (lista != null && lista.isNotEmpty);

            return _SemestreTile(
              numero: semestre,
              enabled: enabled,
              onTap: () {
                if (!enabled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Próximamente disponible'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SemestreDetalle(semestre: semestre, ramos: lista),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _SemestreTile extends StatefulWidget {
  final int numero;
  final bool enabled;
  final VoidCallback onTap;
  const _SemestreTile({
    required this.numero,
    required this.enabled,
    required this.onTap,
  });

  @override
  State<_SemestreTile> createState() => _SemestreTileState();
}

class _SemestreTileState extends State<_SemestreTile> {
  double _scale = 1;
  @override
  Widget build(BuildContext context) {
    final enabled = widget.enabled;
    final start = enabled ? const Color(0xFFEAF2FF) : const Color(0xFFF6F7FB);
    final end = enabled ? const Color(0xFFDDE8FF) : const Color(0xFFF1F2F6);
    final border = enabled ? const Color(0xFF5E60CE) : Colors.black12;

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = .98),
      onTapUp: (_) => setState(() => _scale = 1),
      onTapCancel: () => setState(() => _scale = 1),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [start, end],
            ),
            border: Border.all(color: border),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 4),
                color: Color(0x1A000000),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 32,
                      color: enabled ? const Color(0xFF5E60CE) : Colors.black45,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sem ${widget.numero}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: enabled ? Colors.black : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (!enabled)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Próx.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
