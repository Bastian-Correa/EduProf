import 'package:flutter/material.dart';

class PrincipalProfesores extends StatelessWidget {
  const PrincipalProfesores({super.key});

  // ===== Paleta para mantener el estilo de tu app =====
  static const Color fondo = Color(0xFFF0F4FF);
  static const Color appbarColor = Color.fromARGB(255, 163, 31, 31);

  // Usa rutas a imágenes en assets (o deja vacío para ver el placeholder).
  final Map<String, List<_Profesor>> _profesPorRamo = const {
    'Design Thinking': [
      _Profesor(
        nombre: 'María Soto',
        imagenAsset: 'assets/profesores/maria.jpg',
      ),
      _Profesor(
        nombre: 'Juan Pérez',
        imagenAsset: 'assets/profesores/juan.jpg',
      ),
    ],
    'Programación Estructurada': [
      _Profesor(
        nombre: 'Carlos Díaz',
        imagenAsset: 'assets/profesores/carlos.jpg',
      ),
      _Profesor(
        nombre: 'Ana Rivas',
        imagenAsset: '',
      ), // sin foto -> placeholder
    ],
  };

  @override
  Widget build(BuildContext context) {
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
        itemCount: _profesPorRamo.length,
        itemBuilder: (context, index) {
          final ramo = _profesPorRamo.keys.elementAt(index);
          final lista = _profesPorRamo[ramo]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Encabezado de sección: nombre del Ramo =====
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

              // ===== Dos tarjetas por fila (como en tu boceto) =====
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lista.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columnas
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72, // tarjeta más vertical
                ),
                itemBuilder: (context, i) {
                  final p = lista[i];
                  return _ProfesorCard(
                    profesor: p,
                    onTap: () {
                      // Por ahora solo placeholder
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Abrir perfil de ${p.nombre}'),
                          duration: const Duration(milliseconds: 900),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Modelo interno simple para esta pantalla.
/// (Más adelante lo movemos a lib/models/ y usamos datos reales en lib/data/)
class _Profesor {
  final String nombre;
  final String imagenAsset;
  const _Profesor({required this.nombre, required this.imagenAsset});
}

/// Tarjeta de profesor: imagen grande + nombre
class _ProfesorCard extends StatelessWidget {
  final _Profesor profesor;
  final VoidCallback onTap;

  const _ProfesorCard({required this.profesor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            // Imagen (con fallback si no existe el asset)
            Expanded(
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: profesor.imagenAsset.isNotEmpty
                    ? Image.asset(
                        profesor.imagenAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, st) =>
                            _PlaceholderFoto(nombre: profesor.nombre),
                      )
                    : _PlaceholderFoto(nombre: profesor.nombre),
              ),
            ),
            // Nombre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                profesor.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder bonito con iniciales cuando no hay foto o el asset falla
class _PlaceholderFoto extends StatelessWidget {
  final String nombre;
  const _PlaceholderFoto({required this.nombre});

  String get _iniciales {
    final partes = nombre.trim().split(RegExp(r'\s+'));
    final letras = partes.take(2).map((p) => p.characters.first.toUpperCase());
    return letras.join();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F2F6),
      child: Center(
        child: CircleAvatar(
          radius: 34,
          backgroundColor: const Color(0xFF5E60CE),
          child: Text(
            _iniciales,
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
