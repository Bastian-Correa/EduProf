import 'profesor.dart';

class Ramo {
  final String id;
  final String nombre;
  final String descripcion;
  final int creditos;
  final List<String> requisitosIds; // ids de otros ramos
  final Profesor? profesorAsignado; // null si no hay

  const Ramo({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.creditos,
    this.requisitosIds = const [],
    this.profesorAsignado,
  });
}
