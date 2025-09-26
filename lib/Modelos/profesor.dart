class Profesor {
  final String id;
  final String nombre;
  final String?
  fotoAsset; // null = sin foto (por si acaso si se me olvida algo)

  final String? horario;
  final String? ubicacion;
  final String? bioCorreo;

  const Profesor({
    required this.id,
    required this.nombre,
    this.fotoAsset,
    this.horario,
    this.ubicacion,
    this.bioCorreo,
  });
}
