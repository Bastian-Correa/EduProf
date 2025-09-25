import 'package:flutter/material.dart';
import '/Semestre/semestre_detalles.dart';

class PrincipalSemestres extends StatelessWidget {
  const PrincipalSemestres({super.key});

  static const Color fondo = Color(0xFFF0F4FF);
  static const Color appbarColor = Color.fromARGB(255, 163, 31, 31);

  //Aqui se definen los ramos
  static const Map<int, List<String>> ramosPorSemestre = {
    1: [
      'Design Thinking',
      'Introducción a la ingeneria en Desarrollo de Videojuegos',
      'Programación Estructurada',
    ],
  };

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
            crossAxisCount: 3, // 3 columnas
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final n = index + 1;
            final enabled = ramosPorSemestre.containsKey(
              n,
            ); // habilita si hay datos

            return _SemestreTile(
              numero: n,
              enabled: enabled,
              onTap: () {
                if (enabled) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SemestreDetalle(
                        semestre: n,
                        ramos: ramosPorSemestre[n]!, // pasa la lista
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Próximamente disponible'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
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

class _SemestreTileState extends State<_SemestreTile>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.enabled;

    final Color start = enabled
        ? const Color(0xFFEAF2FF)
        : const Color(0xFFF6F7FB);
    final Color end = enabled
        ? const Color(0xFFDDE8FF)
        : const Color(0xFFF1F2F6);
    final Color border = enabled ? const Color(0xFF5E60CE) : Colors.black12;

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [start, end],
            ),
            border: Border.all(color: border, width: 1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 4),
                color: Color(0x1A000000),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.school_rounded,
                        size: 32,
                        color: enabled
                            ? const Color(0xFF5E60CE)
                            : Colors.black45,
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
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.06),
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
      ),
    );
  }
}
