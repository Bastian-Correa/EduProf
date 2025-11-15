import 'package:flutter/material.dart';
import 'user_prefs.dart';
import 'package:EduProf/Botones_Barra/botones_barra_baja.dart';

class PreferencesScreen extends StatelessWidget {
  final ThemeController controller;
  const PreferencesScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          //color de tema
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Color de tema',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),

                  // rojo
                  RadioListTile<AppBrandColor>(
                    title: const Text('Rojo'),
                    value: AppBrandColor.red,
                    groupValue: controller.brand,
                    onChanged: (v) => controller.setBrand(v!),
                  ),

                  // morado
                  RadioListTile<AppBrandColor>(
                    title: const Text('Morado'),
                    value: AppBrandColor.purple,
                    groupValue: controller.brand,
                    onChanged: (v) => controller.setBrand(v!),
                  ),

                  // verde
                  RadioListTile<AppBrandColor>(
                    title: const Text('Verde'),
                    value: AppBrandColor.green,
                    groupValue: controller.brand,
                    onChanged: (v) => controller.setBrand(v!),
                  ),

                  // azul
                  RadioListTile<AppBrandColor>(
                    title: const Text('Azul'),
                    value: AppBrandColor.blue,
                    groupValue: controller.brand,
                    onChanged: (v) => controller.setBrand(v!),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          //tipo de tema
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tamaño de fuente',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  RadioListTile<AppTextScale>(
                    title: const Text('Normal'),
                    value: AppTextScale.normal,
                    groupValue: controller.textScale,
                    onChanged: (v) => controller.setTextScale(v!),
                  ),
                  RadioListTile<AppTextScale>(
                    title: const Text('Ampliado'),
                    value: AppTextScale.large,
                    groupValue: controller.textScale,
                    onChanged: (v) => controller.setTextScale(v!),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          //Tipo de letra
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tipo de letra',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  RadioListTile<AppFont>(
                    title: const Text('Predeterminada del sistema'),
                    value: AppFont.system,
                    groupValue: controller.font,
                    onChanged: (v) => controller.setFont(v!),
                  ),
                  RadioListTile<AppFont>(
                    title: const Text('Sans'),
                    value: AppFont.sans,
                    groupValue: controller.font,
                    onChanged: (v) => controller.setFont(v!),
                  ),
                  RadioListTile<AppFont>(
                    title: const Text('Serif'),
                    value: AppFont.serif,
                    groupValue: controller.font,
                    onChanged: (v) => controller.setFont(v!),
                  ),
                  RadioListTile<AppFont>(
                    title: const Text('Redondeada'),
                    value: AppFont.rounded,
                    groupValue: controller.font,
                    onChanged: (v) => controller.setFont(v!),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
