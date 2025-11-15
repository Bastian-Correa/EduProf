import 'package:EduProf/Modelos/profesor.dart';

class Ramo {
  final String id;
  final String nombre;
  final String descripcion;
  final int? creditos;

  final List<String> requisitosIds;

  final List<String> requisitosExternos;

  final Profesor? profesorAsignado;

  const Ramo({
    required this.id,
    required this.nombre,
    required this.descripcion,
    this.creditos,
    this.requisitosIds = const [],
    this.requisitosExternos = const [],
    this.profesorAsignado,
  });
}
