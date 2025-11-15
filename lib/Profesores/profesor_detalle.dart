import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:EduProf/Modelos/profesor.dart';
import 'package:EduProf/Modelos/ramo.dart';
import 'package:EduProf/Botones_Barra/botones_barra_baja.dart';
import 'package:EduProf/Botones_Barra/favorites_manager.dart';
import 'package:EduProf/Base de datos/academico.dart';
import 'package:EduProf/Semestre/ramo_detalle.dart';

class ProfesorDetalle extends StatefulWidget {
  final Profesor profesor;
  const ProfesorDetalle({super.key, required this.profesor});

  static const fondo = Color(0xFFF0F4FF);

  @override
  State<ProfesorDetalle> createState() => _ProfesorDetalleState();
}

class _ProfesorDetalleState extends State<ProfesorDetalle> {
  late String _favKey;
  late bool _isFav;

  late List<StudentComment> _comments;

  @override
  void initState() {
    super.initState();
    _favKey = 'prof:${widget.profesor.id}';
    _isFav = FavoritesManager.i.isFav(_favKey);

    _comments = List.of(
      dummyCommentsByProf[widget.profesor.id] ?? const <StudentComment>[],
    );
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

  void _handleAddComment(StudentComment c) {
    setState(() {
      _comments.add(c);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comentario enviado'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> _sendEmail(String rawEmail) async {
    final email = rawEmail.split('\n').first.trim();
    if (email.isEmpty) return;

    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: <String, String>{
        'subject': 'Consulta sobre ramo / horario',
      },
    );

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir la aplicación de correo'),
        ),
      );
    }
  }

  /// Genera un PDF con la ficha del profesor
  Future<void> _shareProfesorPdf(Profesor p) async {
    try {
      final pdf = pw.Document();

      final nombre = p.nombre;
      final rol = (p.bioCorreo ?? '').isNotEmpty
          ? 'Profesor'
          : 'Profesor de la carrera';
      final horario = p.horario ?? 'No informado';
      final oficina = p.ubicacion ?? 'No informada';
      final correo = (p.bioCorreo ?? '').isNotEmpty
          ? p.bioCorreo!.split('\n').first.trim()
          : 'No disponible';
      final bio = (p.bioCorreo ?? '')
          .split('\n')
          .skip(1)
          .join('\n')
          .trim()
          .ifEmpty('Sin biografía disponible.');

      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(24),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  nombre,
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  rol,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Horario de atención',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(horario),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Oficina',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(oficina),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Correo',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(correo),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Bibliografía',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(bio),
                pw.SizedBox(height: 24),
                pw.Text(
                  'Generado con EduProf',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ],
            );
          },
        ),
      );

      final bytes = await pdf.save();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/prof_${p.id}.pdf');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([
        XFile(
          file.path,
          mimeType: 'application/pdf',
          name: 'Profesor_${p.nombre}.pdf',
        ),
      ], text: 'Ficha de ${p.nombre} (EduProf)');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo compartir la ficha del profesor'),
        ),
      );
    }
  }

  // Los ramos del profesor
  void _showRamosProfesor() {
    final lista = ramosDeProfesor(widget.profesor.id);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        final seed = Theme.of(ctx).colorScheme.primary;

        if (lista.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Este profesor aún no tiene ramos asignados en la app.',
              style: TextStyle(fontSize: 14),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Text(
                'Ramos del profesor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: seed,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.profesor.nombre,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: lista.length,
                  separatorBuilder: (_, __) => const Divider(height: 8),
                  itemBuilder: (_, i) {
                    final nombreRamo = lista[i];
                    return ListTile(
                      dense: true,
                      leading: const Icon(Icons.menu_book_rounded),
                      title: Text(nombreRamo),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.pop(ctx);

                        final ramo = buscarRamoPorNombreYProfesor(
                          nombreRamo,
                          widget.profesor.id,
                        );

                        if (ramo != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RamoDetalle(ramo: ramo),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No se encontró el detalle de este ramo.',
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profesor;
    final seed = Theme.of(context).colorScheme.primary;

    double? avgRating;
    if (_comments.isNotEmpty) {
      double sum = 0;
      for (final c in _comments) {
        sum += c.rating;
      }
      avgRating = sum / _comments.length;
    }

    final ramosCount = countRamosDeProfesor(p.id);
    final anios = aniosPorProfesor[p.id] ?? 0;

    return Scaffold(
      backgroundColor: ProfesorDetalle.fondo,
      appBar: AppBar(
        backgroundColor: seed,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 72,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 4),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(.18),
              child: Icon(
                p.rolIcon ?? Icons.school_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.nombre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    (p.bioCorreo ?? '').isNotEmpty
                        ? 'Profesor'
                        : 'Profesor de la carrera',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFEDEBFF),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Compartir ficha',
            icon: const Icon(Icons.share_rounded, color: Colors.white),
            onPressed: () => _shareProfesorPdf(p),
          ),
          IconButton(
            tooltip: _isFav ? 'Quitar de favoritos' : 'Agregar a favoritos',
            onPressed: _toggleFav,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (c, a) => ScaleTransition(scale: a, child: c),
              child: Icon(
                _isFav ? Icons.star_rounded : Icons.star_border_rounded,
                key: ValueKey(_isFav),
                color: _isFav ? Colors.amber : Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Foto principal
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: _SmartPhoto(assetPath: p.fotoAsset),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Horario / Oficina
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _InfoPill(
                    icon: Icons.schedule_rounded,
                    title: 'Horario',
                    value: p.horario ?? '—',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoPill(
                    icon: Icons.location_on_rounded,
                    title: 'Oficina',
                    value: p.ubicacion ?? '—',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Enviar correo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _ActionButton(
              icon: Icons.mail_rounded,
              label: (p.bioCorreo ?? '').isNotEmpty
                  ? 'Enviar correo'
                  : 'Sin correo disponible',
              enabled: (p.bioCorreo ?? '').isNotEmpty,
              onPressed: (p.bioCorreo ?? '').isNotEmpty
                  ? () => _sendEmail(p.bioCorreo!)
                  : () {},
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _BigBlock(
              title: 'Bibliografía / Contacto',
              content: p.bioCorreo ?? '—',
            ),
          ),

          const SizedBox(height: 16),

          // Estadísticas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _StatCard(
                  icon: Icons.menu_book_rounded,
                  label: 'Ramos',
                  value: ramosCount > 0 ? ramosCount.toString() : '—',
                  onTap: ramosCount > 0 ? _showRamosProfesor : null,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  icon: Icons.star_rate_rounded,
                  label: 'Valoración',
                  value: avgRating != null
                      ? avgRating!.toStringAsFixed(1)
                      : '—',
                ),
                const SizedBox(width: 12),
                _StatCard(
                  icon: Icons.work_history_rounded,
                  label: 'Años',
                  value: anios > 0 ? anios.toString() : '—',
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // comentarios
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _CommentsSection(
              comments: _comments,
              onAddComment: _handleAddComment,
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _InfoPill({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: seed.withOpacity(.12),
            child: Icon(icon, size: 18, color: seed),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(''),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onPressed;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: seed,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.black12,
          disabledForegroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _BigBlock extends StatelessWidget {
  final String title;
  final String content;
  const _BigBlock({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: seed.withOpacity(.12),
                child: Icon(icon, size: 18, color: seed),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Comentarios de estudiantes

class _CommentsSection extends StatefulWidget {
  final List<StudentComment> comments;
  final ValueChanged<StudentComment> onAddComment;

  const _CommentsSection({required this.comments, required this.onAddComment});

  @override
  State<_CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<_CommentsSection> {
  bool _expanded = true;

  final _nameCtrl = TextEditingController();
  final _detailCtrl = TextEditingController();
  final _textCtrl = TextEditingController();
  double _newRating = 4.0;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _detailCtrl.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasComments = widget.comments.isNotEmpty;

    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.chat_rounded, size: 20, color: Colors.black54),
                const SizedBox(width: 8),
                const Text(
                  'Comentarios de estudiantes',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    setState(() => _expanded = !_expanded);
                  },
                  icon: AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _expanded ? 0.0 : 0.5,
                    child: const Icon(Icons.expand_more_rounded),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: !_expanded
                  ? const SizedBox.shrink(key: ValueKey('collapsed'))
                  : hasComments
                  ? Column(
                      key: const ValueKey('list'),
                      children: widget.comments
                          .map(
                            (c) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: _CommentCard(comment: c),
                            ),
                          )
                          .toList(),
                    )
                  : const Padding(
                      key: ValueKey('empty'),
                      padding: EdgeInsets.only(top: 4, bottom: 8),
                      child: Text(
                        'Aún no hay comentarios para este profesor.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'Agregar comentario',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre (opcional)',
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _detailCtrl,
              decoration: const InputDecoration(
                labelText: 'Detalle (ej. "3er año · IDVRV")',
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Tu comentario',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Valoración:'),
                Expanded(
                  child: Slider(
                    value: _newRating,
                    min: 1,
                    max: 5,
                    divisions: 8,
                    label: _newRating.toStringAsFixed(1),
                    onChanged: (v) => setState(() => _newRating = v),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_textCtrl.text.trim().isEmpty) return;

                  final c = StudentComment(
                    author: _nameCtrl.text.trim().isEmpty
                        ? 'Estudiante anónimo'
                        : _nameCtrl.text.trim(),
                    detail: _detailCtrl.text.trim(),
                    text: _textCtrl.text.trim(),
                    when: 'recién',
                    rating: _newRating,
                  );

                  widget.onAddComment(c);

                  _nameCtrl.clear();
                  _detailCtrl.clear();
                  _textCtrl.clear();
                  setState(() => _newRating = 4.0);
                },
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  final StudentComment comment;
  const _CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    final initial = comment.author.trim().isNotEmpty
        ? comment.author.trim()[0].toUpperCase()
        : '?';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FF),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: seed.withOpacity(.12),
            child: Text(
              initial,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.author,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    _Stars(rating: comment.rating),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${comment.detail} · ${comment.when}',
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(comment.text, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  final double rating;
  const _Stars({required this.rating});

  @override
  Widget build(BuildContext context) {
    final full = rating.floor();
    final hasHalf = (rating - full) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < full) {
          return const Icon(Icons.star_rounded, size: 14, color: Colors.amber);
        } else if (i == full && hasHalf) {
          return const Icon(
            Icons.star_half_rounded,
            size: 14,
            color: Colors.amber,
          );
        } else {
          return const Icon(
            Icons.star_border_rounded,
            size: 14,
            color: Colors.amber,
          );
        }
      }),
    );
  }
}

class _SmartPhoto extends StatefulWidget {
  final String? assetPath;
  const _SmartPhoto({required this.assetPath});

  @override
  State<_SmartPhoto> createState() => _SmartPhotoState();
}

class _SmartPhotoState extends State<_SmartPhoto> {
  double? _aspect;

  @override
  void initState() {
    super.initState();
    _resolveImage();
  }

  Future<void> _resolveImage() async {
    final path = widget.assetPath;
    if (path == null || path.isEmpty) return;
    final provider = AssetImage(path);
    final stream = provider.resolve(const ImageConfiguration());
    ImageStreamListener? listener;
    listener = ImageStreamListener(
      (ImageInfo info, bool _) {
        final w = info.image.width.toDouble();
        final h = info.image.height.toDouble();
        setState(() => _aspect = w / h);
        stream.removeListener(listener!);
      },
      onError: (_, __) {
        stream.removeListener(listener!);
      },
    );
    stream.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final path = widget.assetPath;
    if (path == null || path.isEmpty) {
      return Container(
        color: const Color(0xFFF1F2F6),
        height: 260,
        child: const Center(
          child: Icon(Icons.person_rounded, size: 64, color: Colors.black26),
        ),
      );
    }

    final aspect = _aspect ?? (4 / 3);
    final isPortrait = aspect < 1.0;

    if (isPortrait) {
      return SizedBox(
        height: 260,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Image.asset(path, fit: BoxFit.cover),
            ),
            Container(color: Colors.black.withOpacity(0.08)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Image.asset(path, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      );
    }

    return AspectRatio(
      aspectRatio: aspect,
      child: Image.asset(
        path,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

extension on String {
  String ifEmpty(String value) => isEmpty ? value : this;
}

String _primerasPalabras(String s, int n) {
  final limpio = s.replaceAll('\n', ' ').trim();
  final parts = limpio.split(RegExp(r'\s+'));
  return parts.length <= n ? limpio : parts.take(n).join(' ');
}

/// Devuelve la lista de nombres de ramos para un profesor
List<String> ramosDeProfesor(String profesorId) {
  final nombres = <String>{};

  for (final ramo in ramosPorSemestre.values.expand((l) => l)) {
    final prof = ramo.profesorAsignado;
    if (prof != null && prof.id == profesorId) {
      nombres.add(ramo.nombre);
    }
  }

  final lista = nombres.toList()..sort();
  return lista;
}

/// Busca un ramo por nombre y profesor, usando la malla
Ramo? buscarRamoPorNombreYProfesor(String nombre, String profesorId) {
  for (final lista in ramosPorSemestre.values) {
    for (final ramo in lista) {
      if (ramo.nombre == nombre &&
          ramo.profesorAsignado != null &&
          ramo.profesorAsignado!.id == profesorId) {
        return ramo;
      }
    }
  }
  return null;
}
