import 'package:flutter/material.dart';
import 'package:EduProf/Modelos/ramo.dart';
import 'package:EduProf/Profesores/profesor_detalle.dart';
import 'package:EduProf/Botones_Barra/botones_barra_baja.dart';
import 'package:EduProf/Botones_Barra/favorites_manager.dart';
import 'package:EduProf/Base de datos/academico.dart';

class RamoDetalle extends StatefulWidget {
  final Ramo ramo;
  const RamoDetalle({super.key, required this.ramo});

  static const fondo = Color(0xFFF0F4FF);

  @override
  State<RamoDetalle> createState() => _RamoDetalleState();
}

class _RamoDetalleState extends State<RamoDetalle> {
  late String _favKey;
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _favKey = 'ramo:${widget.ramo.id}';
    _isFav = FavoritesManager.i.isFav(_favKey);
  }

  void _toggleFav() {
    final nowFav = FavoritesManager.i.toggle(_favKey);
    setState(() => _isFav = nowFav);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          nowFav ? 'Guardado a favoritos' : 'Eliminado de favoritos',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  String _requisitosLabel(Ramo r) {
    final nombres = <String>[];

    for (final id in r.requisitosIds) {
      final encontrado = ramoById(id);
      nombres.add(encontrado?.nombre ?? id);
    }

    nombres.addAll(r.requisitosExternos);

    if (nombres.isEmpty) return '—';
    return nombres.join(', ');
  }

  void _openRequisitos() {
    final ids = widget.ramo.requisitosIds;
    if (ids.isEmpty) return;

    final List<Ramo> ramosReq = [];
    for (final id in ids) {
      final r = ramoById(id);
      if (r != null) ramosReq.add(r);
    }

    if (ramosReq.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se encontró el ramo requerido')),
      );
      return;
    }

    // Si solo hay 1 requisito, vamos directo
    if (ramosReq.length == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RamoDetalle(ramo: ramosReq.first)),
      );
      return;
    }

    // Si hay varios, mostramos un bottom sheet para elegir
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ramos requeridos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              for (final r in ramosReq)
                ListTile(
                  title: Text(r.nombre),
                  subtitle: Text(r.id),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RamoDetalle(ramo: r)),
                    );
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.ramo;
    final seed = Theme.of(context).colorScheme.primary;

    // Datos extra
    final dificultad = dificultadPorRamo[r.id] ?? 'Media';
    final workload = workloadPorRamo[r.id] ?? '4–6 h/sem';
    final modalidad = modalidadPorRamo[r.id] ?? 'Presencial';
    final evalItems = evalPorRamo[r.id] ?? const <EvalItem>[];

    return Scaffold(
      backgroundColor: RamoDetalle.fondo,
      appBar: AppBar(
        // Título vacío para que no se repita el nombre
        title: const Text(''),
        actions: [
          IconButton(
            tooltip: _isFav ? 'Quitar de favoritos' : 'Agregar a favoritos',
            onPressed: _toggleFav,
            icon: Icon(_isFav ? Icons.star_rounded : Icons.star_border_rounded),
            color: _isFav ? Colors.amber : Colors.white,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HeaderRamo(
            nombre: r.nombre,
            dificultad: dificultad,
            workload: workload,
            modalidad: modalidad,
          ),
          const SizedBox(height: 16),

          _SectionCard(
            title: 'De qué trata',
            child: Text(
              r.descripcion,
              style: const TextStyle(fontSize: 16, height: 1.3),
            ),
          ),
          const SizedBox(height: 12),

          // creditos y requisitos
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _MiniStatCard(
                    title: 'Créditos',
                    icon: Icons.timeline_rounded,
                    value: r.creditos != null ? r.creditos.toString() : '—',
                    color: seed,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MiniStatCard(
                    title: 'Requiere',
                    icon: Icons.link_rounded,
                    value: _requisitosLabel(r),
                    color: seed,
                    isLink: r.requisitosIds.isNotEmpty,
                    onTap: r.requisitosIds.isEmpty ? null : _openRequisitos,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // evaluación del ramo
          if (evalItems.isNotEmpty) ...[
            _SectionCard(
              title: 'Evaluación del ramo',
              child: Column(
                children: [
                  for (final e in evalItems) ...[
                    _EvalRow(item: e),
                    const SizedBox(height: 6),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          if (tagsPorRamo[r.id]?.isNotEmpty ?? false) ...[
            _SectionCard(
              title: 'Recomendado para',
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  for (final t in tagsPorRamo[r.id]!) _TagChip(text: t),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // profesor asignado
          _SectionCard(
            title: 'Profesor asignado',
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                final p = r.profesorAsignado;
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
                padding: const EdgeInsets.only(right: 6, top: 4, bottom: 4),
                child: Row(
                  children: [
                    _ProfFoto(ramo: r),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.profesorAsignado?.nombre ?? 'Por asignar',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            r.profesorAsignado != null
                                ? 'Ver perfil del profesor'
                                : 'Se asignará más adelante',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
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

          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _HeaderRamo extends StatelessWidget {
  final String nombre;
  final String dificultad;
  final String workload;
  final String modalidad;

  const _HeaderRamo({
    required this.nombre,
    required this.dificultad,
    required this.workload,
    required this.modalidad,
  });

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: seed.withOpacity(.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.menu_book_rounded, color: seed, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  nombre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _InfoChip(
                icon: Icons.speed_rounded,
                label: 'Dificultad',
                value: dificultad,
              ),
              _InfoChip(
                icon: Icons.access_time_rounded,
                label: 'Carga',
                value: workload,
              ),
              _InfoChip(
                icon: Icons.laptop_mac_rounded,
                label: 'Modalidad',
                value: modalidad,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: seed.withOpacity(.06),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: seed),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
          Text(value, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
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
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isLink;
  final VoidCallback? onTap;

  const _MiniStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isLink = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: isLink ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: color.withOpacity(.08),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: isLink
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        color: isLink ? Colors.indigo : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfFoto extends StatelessWidget {
  final Ramo ramo;
  const _ProfFoto({required this.ramo});

  @override
  Widget build(BuildContext context) {
    final asset = ramo.profesorAsignado?.fotoAsset;
    if (asset == null || asset.isEmpty) {
      return const CircleAvatar(radius: 26, child: Icon(Icons.person_rounded));
    }
    return CircleAvatar(radius: 26, backgroundImage: AssetImage(asset));
  }
}

class _TagChip extends StatelessWidget {
  final String text;
  const _TagChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text, style: const TextStyle(fontSize: 12)),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      backgroundColor: const Color(0xFFEFF1FF),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

class _EvalRow extends StatelessWidget {
  final EvalItem item;
  const _EvalRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        Expanded(child: Text(item.label, style: const TextStyle(fontSize: 14))),
        const SizedBox(width: 8),
        SizedBox(
          width: 120,
          child: Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: item.percent / 100,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: seed,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${item.percent}%',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
