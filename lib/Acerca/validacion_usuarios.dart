import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

class ValidacionUsuariosScreen extends StatefulWidget {
  const ValidacionUsuariosScreen({super.key});

  @override
  State<ValidacionUsuariosScreen> createState() =>
      _ValidacionUsuariosScreenState();
}

class _ValidacionUsuariosScreenState extends State<ValidacionUsuariosScreen> {
  Map<String, dynamic> data = {};
  bool loading = true;

  // Controlador para el nombre del usuario
  final TextEditingController nombreCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    super.dispose();
  }

  Future<void> loadJson() async {
    final raw = await rootBundle.loadString("assets/validacion.json");
    setState(() {
      data = json.decode(raw);
      loading = false;
    });
  }

  Future<void> enviarCorreo() async {
    // Validación rápida del nombre
    if (nombreCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor ingresa tu nombre antes de enviar."),
        ),
      );
      return;
    }

    final buffer = StringBuffer();

    buffer.writeln("VALIDACIÓN DE USUARIO – EduProf\n");
    buffer.writeln("Nombre del usuario: ${nombreCtrl.text.trim()}\n");

    data.forEach((categoria, preguntas) {
      buffer.writeln("\n=== ${categoria.toString().toUpperCase()} ===");
      for (var p in preguntas) {
        buffer.writeln("\n${p['titulo']}");
        buffer.writeln("Valor: ${p['valor']} estrellas");
      }
    });

    final uri = Uri(
      scheme: 'mailto',
      path: 'bcorrea23@alumnos.utalca.cl',
      query:
          'subject=Validación EduProf&body=${Uri.encodeComponent(buffer.toString())}',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo abrir el correo.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;

    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: seed,
        title: const Text(
          "Validación de usuarios",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          //Campo para el nombre del usuario
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tu nombre",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(
                    hintText: "Ingresa tu nombre...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Preguntas por categoría
          for (var categoria in data.keys) ...[
            Text(
              categoria.toUpperCase(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),

            for (var p in data[categoria])
              _PreguntaItem(pregunta: p, seed: seed),

            const SizedBox(height: 24),
          ],

          // Botón de enviar
          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: seed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                foregroundColor: Colors.white,
              ),
              onPressed: enviarCorreo,
              icon: const Icon(Icons.send_rounded),
              label: const Text(
                "Enviar respuestas",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreguntaItem extends StatefulWidget {
  final Map<String, dynamic> pregunta;
  final Color seed;

  const _PreguntaItem({required this.pregunta, required this.seed});

  @override
  State<_PreguntaItem> createState() => _PreguntaItemState();
}

class _PreguntaItemState extends State<_PreguntaItem> {
  @override
  Widget build(BuildContext context) {
    final p = widget.pregunta;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              p["titulo"],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            // ESTRELLAS
            Row(
              children: [
                for (int i = 1; i <= 5; i++)
                  IconButton(
                    onPressed: () {
                      setState(() => p["valor"] = i);
                    },
                    icon: Icon(
                      Icons.star_rounded,
                      color: i <= (p["valor"] ?? 0)
                          ? widget.seed
                          : Colors.grey.shade300,
                      size: 28,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 6),
            Text("0 → ${p["min"]}", style: const TextStyle(fontSize: 12)),
            Text("5 → ${p["max"]}", style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
