import 'package:EduProf/Modelos/profesor.dart';
import 'package:EduProf/Modelos/ramo.dart';

/// Profesores “globales”
const profesores = <Profesor>[
  Profesor(
    id: 'p1',
    nombre: 'María Soto',
    fotoAsset: 'assets/maria.jpg',
    horario: 'Lunes 10:00–12:00',
    ubicacion: 'Edificio de Videojuegos',
    bioCorreo:
        'msoto@utalca.cl\n\nMentora en innovación, UX y metodologías ágiles. Participa en proyectos de Design Thinking aplicados a educación digital.',
  ),
  Profesor(
    id: 'p2',
    nombre: 'Juan Pérez',
    fotoAsset: 'assets/juan.jpg',
    horario: 'Jueves 09:00–11:00',
    ubicacion: 'Edificio de Videojuegos',
    bioCorreo:
        'jperez@utalca.cl\n\nEspecialista en diseño narrativo y storytelling para videojuegos. Experiencia en gamificación y guion interactivo.',
  ),
  Profesor(
    id: 'p3',
    nombre: 'Carlos Díaz',
    fotoAsset: 'assets/carlos.jpg',
    horario: 'Miércoles 15:00–17:00',
    ubicacion: 'Edificio de Videojuegos',
    bioCorreo:
        'cdiaz@utalca.cl\n\nProfesor de programación en C y estructuras de datos. Interés en optimización de algoritmos y enseñanza de bases de programación.',
  ),
];

Profesor? profById(String id) => profesores.firstWhere(
  (p) => p.id == id,
  orElse: () => const Profesor(id: 'none', nombre: '—'),
);

/// Ramos por semestre
final ramosPorSemestre = <int, List<Ramo>>{
  1: [
    Ramo(
      id: 'r_dt',
      nombre: 'Design Thinking',
      descripcion:
          'Metodología centrada en las personas para idear, prototipar y validar soluciones.',
      creditos: 5,
      requisitosIds: const [], // sin requisitos
      profesorAsignado: profesores[0], // María
    ),
    Ramo(
      id: 'r_intro_vj',
      nombre: 'Introducción a la ingeniería en Desarrollo de Videojuegos',
      descripcion:
          'Panorama general de la industria y bases del desarrollo de videojuegos.',
      creditos: 4,
      requisitosIds: const [],
      profesorAsignado: profesores[1],
    ),
    Ramo(
      id: 'r_prog_estruct',
      nombre: 'Programación Estructurada',
      descripcion:
          'Fundamentos de programación: variables, control de flujo, funciones.',
      creditos: 6,
      requisitosIds: const [],
      profesorAsignado: profesores[2],
    ),
  ],
  //Mas adelante para los diferentes ramos aqui declaro el numero 2: [...], 3: [...], etc.
};
