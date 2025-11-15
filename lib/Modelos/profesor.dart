import 'package:flutter/material.dart';

class Profesor {
  final String id;
  final String nombre;
  final String? fotoAsset;

  final String? horario;
  final String? ubicacion;
  final String? bioCorreo;

  final IconData? rolIcon;

  const Profesor({
    required this.id,
    required this.nombre,
    this.fotoAsset,
    this.horario,
    this.ubicacion,
    this.bioCorreo,
    this.rolIcon,
  });
}
