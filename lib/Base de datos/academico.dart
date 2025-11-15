import 'package:flutter/material.dart';
import 'package:EduProf/Modelos/profesor.dart';
import 'package:EduProf/Modelos/ramo.dart';

/// Profesores “globales”
const profesores = <Profesor>[
  // Profesor de Design Thinking y UX
  Profesor(
    id: 'p1',
    nombre: 'María Soto',
    fotoAsset: 'assets/maria.jpg',
    horario: 'Lunes 10:00–12:00',
    ubicacion: 'Edificio de Videojuegos',
    bioCorreo:
        'msoto@utalca.cl\n\nMentora en innovación, UX y metodologías ágiles. '
        'Participa en proyectos de Design Thinking aplicados a educación digital.',
    rolIcon: Icons.brush_rounded,
  ),

  //Profesor de introducción a videojuegos y narrativa
  Profesor(
    id: 'p2',
    nombre: 'Juan Pérez',
    fotoAsset: 'assets/juan.jpg',
    horario: 'Jueves 09:00–11:00',
    ubicacion: 'Edificio de Videojuegos',
    bioCorreo:
        'jperez@utalca.cl\n\nEspecialista en diseño narrativo y storytelling '
        'para videojuegos. Experiencia en gamificación y guion interactivo.',
    rolIcon: Icons.menu_book_rounded,
  ),

  // Profesor de programación básica y estructurada
  Profesor(
    id: 'p3',
    nombre: 'Carlos Díaz',
    fotoAsset: 'assets/carlos.jpg',
    horario: 'Miércoles 15:00–17:00',
    ubicacion: 'Edificio de Videojuegos',
    bioCorreo:
        'cdiaz@utalca.cl\n\nProfesor de programación en C y estructuras de datos. '
        'Interés en optimización de algoritmos y enseñanza de bases de programación.',
    rolIcon: Icons.code_rounded,
  ),

  // Programación avanzada / motores de juego
  Profesor(
    id: 'p4',
    nombre: 'Andrés Valdivia',
    fotoAsset: 'assets/andres_valdivia.jpg',
    horario: 'Martes 10:00–12:00',
    ubicacion: 'Laboratorio de Motores de Juego',
    bioCorreo:
        'avaldivia@utalca.cl\n\nIngeniero de software especializado en motores de juego '
        'y programación avanzada. Ha trabajado con Unity y Unreal en proyectos académicos '
        'y comerciales.',
    rolIcon: Icons.developer_mode_rounded,
  ),

  // Física y matemáticas para videojuegos
  Profesor(
    id: 'p5',
    nombre: 'Rodrigo Herrera',
    fotoAsset: 'assets/rodrigo_herrera.png',
    horario: 'Lunes 15:00–17:00',
    ubicacion: 'Edificio de Ciencias Básicas',
    bioCorreo:
        'rherrera@utalca.cl\n\nFísico con experiencia en simulación numérica y motores '
        'de física para videojuegos. Le interesan las colisiones, partículas y dinámicas '
        'de cuerpos rígidos.',
    rolIcon: Icons.science_rounded,
  ),

  // Arte y UI 2D
  Profesor(
    id: 'p6',
    nombre: 'Daniela Morales',
    fotoAsset: 'assets/daniela_morales.png',
    horario: 'Miércoles 09:00–11:00',
    ubicacion: 'Laboratorio de Arte Digital',
    bioCorreo:
        'dmorales@utalca.cl\n\nArtista digital enfocada en ilustración, sprites y UI para '
        'videojuegos 2D. Ha colaborado en proyectos indie y en prototipos de investigación.',
    rolIcon: Icons.palette_rounded,
  ),

  // Arte 3D y realidad virtual
  Profesor(
    id: 'p7',
    nombre: 'Felipe Rojas',
    fotoAsset: 'assets/felipe.png',
    horario: 'Jueves 14:00–16:00',
    ubicacion: 'Laboratorio de Modelado 3D',
    bioCorreo:
        'frojas@utalca.cl\n\nDiseñador 3D especializado en modelado low-poly, optimización '
        'de assets y flujos de trabajo para realidad virtual y aumentada.',
    rolIcon: Icons.view_in_ar_rounded,
  ),

  // Sistemas operativos y redes
  Profesor(
    id: 'p8',
    nombre: 'Patricia Navarro',
    fotoAsset: 'assets/patricia_navarro.png',
    horario: 'Viernes 10:00–12:00',
    ubicacion: 'Laboratorio de Sistemas',
    bioCorreo:
        'pnavarro@utalca.cl\n\nIngeniera en informática con experiencia en sistemas '
        'operativos, redes y despliegue de servicios para aplicaciones en línea y juegos.',
    rolIcon: Icons.memory_rounded,
  ),

  // Gestión, negocios y emprendimiento
  Profesor(
    id: 'p9',
    nombre: 'Sergio Guzmán',
    fotoAsset: 'assets/sergio_guzman.png',
    horario: 'Martes 18:00–20:00',
    ubicacion: 'Facultad de Economía y Negocios',
    bioCorreo:
        'sguzman@utalca.cl\n\nConsultor en negocios digitales y emprendimiento. Trabaja en '
        'modelos de negocio, monetización y pitch de proyectos de videojuegos.',
    rolIcon: Icons.business_center_rounded,
  ),

  // Ética, sociedad y aspectos legales
  Profesor(
    id: 'p10',
    nombre: 'Laura Medina',
    fotoAsset: 'assets/laura_medina.png',
    horario: 'Jueves 11:00–13:00',
    ubicacion: 'Facultad de Ciencias Jurídicas',
    bioCorreo:
        'lmedina@utalca.cl\n\nAbogada especializada en propiedad intelectual, derecho de '
        'software y regulación de contenidos interactivos. Interesada en el impacto social '
        'de los videojuegos.',
    rolIcon: Icons.gavel_rounded,
  ),
];

/// Años de experiencia aproximados por profesor
const Map<String, int> aniosPorProfesor = {
  'p1': 5, // María Soto
  'p2': 7, // Juan Pérez
  'p3': 6, // Carlos Díaz
  'p4': 8, // Andrés Valdivia
  'p5': 10, // Rodrigo Herrera
  'p6': 4, // Daniela Morales
  'p7': 6, // Felipe Rojas
  'p8': 9, // Patricia Navarro
  'p9': 12, // Sergio Guzmán
  'p10': 7, // Laura Medina
};

Profesor? profById(String id) => profesores.firstWhere(
  (p) => p.id == id,
  orElse: () => const Profesor(id: 'none', nombre: '—'),
);

Profesor? profesorById(String id) {
  try {
    return profesores.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
}

/// Busca un ramo en toda la malla por id
Ramo? ramoById(String id) {
  for (final lista in ramosPorSemestre.values) {
    for (final r in lista) {
      if (r.id == id) return r;
    }
  }
  return null;
}

/// Cuenta cuántos ramos tiene asignados un profesor en toda la malla
int countRamosDeProfesor(String profesorId) {
  var count = 0;
  for (final lista in ramosPorSemestre.values) {
    for (final r in lista) {
      if (r.profesorAsignado?.id == profesorId) {
        count++;
      }
    }
  }
  return count;
}

// Ramos por semestre

final ramosPorSemestre = <int, List<Ramo>>{
  // Semestre 1 – Año 1
  1: [
    Ramo(
      id: 'r_dt',
      nombre: 'Design Thinking',
      descripcion:
          'Metodología centrada en las personas para idear, prototipar y '
          'validar soluciones.',
      creditos: 5,
      requisitosIds: const [],
      profesorAsignado: profesores[0], // María Soto
    ),
    Ramo(
      id: 'r_intro_vj',
      nombre: 'Introducción a la ingeniería en Desarrollo de Videojuegos',
      descripcion:
          'Panorama general de la industria y bases del desarrollo de '
          'videojuegos como disciplina de ingeniería.',
      creditos: 4,
      requisitosIds: const [],
      profesorAsignado: profesores[1], // Juan Pérez
    ),
    Ramo(
      id: 'r_prog_estruct',
      nombre: 'Programación Estructurada',
      descripcion:
          'Fundamentos de programación: variables, control de flujo, '
          'funciones y solución de problemas básicos.',
      creditos: 6,
      requisitosIds: const [],
      profesorAsignado: profesores[2], // Carlos Díaz
    ),
  ],

  // Semestre 2 – Año 1
  2: [
    Ramo(
      id: 'r_taller_met',
      nombre: 'Taller de Metodologías y Procesos Creativos',
      descripcion:
          'Exploración de metodologías creativas para idear conceptos de '
          'juegos, prototipos rápidos y trabajo colaborativo.',
      creditos: 5,
      requisitosIds: const ['r_dt'],
      profesorAsignado: profesores[0],
    ),
    Ramo(
      id: 'r_taller_vj1',
      nombre: 'Taller Inicial de Videojuegos',
      descripcion:
          'Primer acercamiento práctico a la creación de videojuegos '
          'utilizando motores simples y proyectos guiados.',
      creditos: 5,
      requisitosIds: const ['r_intro_vj'],
      profesorAsignado: profesores[1],
    ),
    Ramo(
      id: 'r_prog_objetos',
      nombre: 'Programación Orientada a Objetos',
      descripcion:
          'Principios de orientación a objetos aplicados al desarrollo de '
          'software: clases, herencia, polimorfismo y abstracción.',
      creditos: 6,
      requisitosIds: const ['r_prog_estruct'],
      profesorAsignado: profesores[2],
    ),
  ],

  // Semestre 3 – Año 2
  3: [
    Ramo(
      id: 'r_prod_2d',
      nombre: 'Producción Digital 2D',
      descripcion:
          'Producción de recursos visuales 2D para videojuegos: sprites, '
          'interfaces e ilustraciones básicas.',
      creditos: 5,
      requisitosIds: const ['r_taller_met'],
      profesorAsignado: profesores[5], // Daniela
    ),
    Ramo(
      id: 'r_prog_vj2d',
      nombre: 'Programación de Videojuegos 2D',
      descripcion:
          'Construcción de juegos 2D utilizando un motor de videojuegos, '
          'manejo de escenas, físicas simples e input.',
      creditos: 6,
      requisitosIds: const ['r_prog_objetos', 'r_taller_vj1'],
      profesorAsignado: profesores[3], // Andrés
    ),
    Ramo(
      id: 'r_alg_edd',
      nombre: 'Algoritmos y Estructura de Datos',
      descripcion:
          'Estudio de algoritmos clásicos y estructuras de datos para el '
          'almacenamiento y procesamiento eficiente de información.',
      creditos: 6,
      requisitosIds: const ['r_prog_objetos'],
      profesorAsignado: profesores[2], // Carlos
    ),
  ],

  // Semestre 4 – Año 2
  4: [
    Ramo(
      id: 'r_fisica_vj',
      nombre: 'Física para Videojuegos',
      descripcion:
          'Aplicación de conceptos de física clásica al comportamiento de '
          'objetos en videojuegos: movimiento, colisiones y fuerzas.',
      creditos: 5,
      requisitosIds: const [],
      requisitosExternos: const ['Física General'],
      profesorAsignado: profesores[4], // Rodrigo
    ),
    Ramo(
      id: 'r_taller_vj2d',
      nombre: 'Taller de Videojuegos 2D',
      descripcion:
          'Desarrollo de un proyecto 2D de mayor escala, integrando arte, '
          'programación y diseño de niveles.',
      creditos: 6,
      requisitosIds: const ['r_prog_vj2d', 'r_prod_2d'],
      profesorAsignado: profesores[3],
    ),
    Ramo(
      id: 'r_bd',
      nombre: 'Bases de Datos',
      descripcion:
          'Fundamentos de bases de datos relacionales, modelado de datos y '
          'lenguaje SQL aplicado a proyectos de software.',
      creditos: 5,
      requisitosIds: const ['r_alg_edd'],
      profesorAsignado: profesores[2],
    ),
  ],

  // Semestre 5 – Año 3
  5: [
    Ramo(
      id: 'r_diseno_vj',
      nombre: 'Diseño de Videojuegos',
      descripcion:
          'Profundización en mecánicas, dinámicas, estética y balance de '
          'videojuegos. Diseño centrado en la experiencia del jugador.',
      creditos: 6,
      requisitosIds: const ['r_taller_vj2d'],
      profesorAsignado: profesores[1],
    ),
    Ramo(
      id: 'r_ia',
      nombre: 'Inteligencia Artificial',
      descripcion:
          'Técnicas de IA utilizadas en videojuegos: máquinas de estados, '
          'árboles de comportamiento, pathfinding y agentes.',
      creditos: 6,
      requisitosIds: const ['r_alg_edd'],
      profesorAsignado: profesores[3],
    ),
    Ramo(
      id: 'r_prod_3d',
      nombre: 'Producción Digital 3D',
      descripcion:
          'Modelado, texturizado e implementación de assets 3D para motores '
          'de videojuegos.',
      creditos: 5,
      requisitosIds: const ['r_prod_2d'],
      profesorAsignado: profesores[6], // Felipe
    ),
    Ramo(
      id: 'r_fund_comp_graf',
      nombre: 'Fundamentos de Computación Gráfica',
      descripcion:
          'Conceptos básicos de renderizado, pipelines gráficos y manejo de '
          'mallas y materiales.',
      creditos: 5,
      requisitosIds: const ['r_fisica_vj'],
      requisitosExternos: const ['Álgebra Lineal'],
      profesorAsignado: profesores[4], // Rodrigo
    ),
  ],

  // Semestre 6 – Año 3
  6: [
    Ramo(
      id: 'r_prog_movil',
      nombre: 'Programación para Dispositivos Móviles',
      descripcion:
          'Desarrollo de aplicaciones y juegos para dispositivos móviles, '
          'considerando rendimiento e interacción táctil.',
      creditos: 5,
      requisitosIds: const ['r_prog_vj2d'],
      profesorAsignado: profesores[3],
    ),
    Ramo(
      id: 'r_usabilidad',
      nombre: 'Usabilidad e Interfaces',
      descripcion:
          'Diseño de interfaces centradas en el usuario, pruebas de usabilidad '
          'y accesibilidad en videojuegos.',
      creditos: 4,
      requisitosIds: const ['r_diseno_vj'],
      profesorAsignado: profesores[0],
    ),
    Ramo(
      id: 'r_sisop_redes',
      nombre: 'Sistemas Operativos y Redes',
      descripcion:
          'Conceptos esenciales de sistemas operativos y redes aplicados a '
          'aplicaciones y juegos conectados.',
      creditos: 5,
      requisitosIds: const ['r_bd'],
      profesorAsignado: profesores[7], // Patricia
    ),
    Ramo(
      id: 'r_prog_vj3d',
      nombre: 'Programación de Videojuegos 3D',
      descripcion:
          'Implementación de juegos 3D usando motores modernos, físicas, '
          'animaciones y manejo de cámaras.',
      creditos: 6,
      requisitosIds: const ['r_prog_vj2d', 'r_fund_comp_graf'],
      profesorAsignado: profesores[3],
    ),
    Ramo(
      id: 'r_vr_avanzada',
      nombre: 'Realidades Virtual y Aumentada',
      descripcion:
          'Desarrollo de experiencias de realidad virtual y tecnologías '
          'inmersivas relacionadas.',
      creditos: 5,
      requisitosIds: const ['r_prod_2d'],
      profesorAsignado: profesores[6],
    ),
  ],

  // Semestre 7 – Año 4
  7: [
    Ramo(
      id: 'r_taller_vj3d',
      nombre: 'Taller de Videojuegos 3D',
      descripcion:
          'Desarrollo de un proyecto 3D de alcance mayor, trabajando en '
          'equipos multidisciplinares.',
      creditos: 6,
      requisitosIds: const ['r_prog_vj3d', 'r_diseno_vj'],
      profesorAsignado: profesores[6],
    ),
    Ramo(
      id: 'r_modelos_negocio',
      nombre: 'Modelos de Negocio de Videojuegos',
      descripcion:
          'Estudio de modelos de negocio, monetización y mercado de la '
          'industria de videojuegos.',
      creditos: 4,
      requisitosIds: const [],
      requisitosExternos: const ['Comprensión de Contextos Sociales'],
      profesorAsignado: profesores[8],
    ),
    Ramo(
      id: 'r_ing_software',
      nombre: 'Ingeniería de Software',
      descripcion:
          'Procesos, patrones y buenas prácticas de ingeniería de software '
          'aplicados a proyectos de juegos.',
      creditos: 6,
      requisitosIds: const ['r_sisop_redes'],
      profesorAsignado: profesores[7],
    ),
  ],

  // Semestre 8 – Año 4
  8: [
    Ramo(
      id: 'r_proy_memoria',
      nombre: 'Proyecto de Memoria de Título',
      descripcion:
          'Formulación y desarrollo inicial de un proyecto de memoria de '
          'título en el área de videojuegos.',
      creditos: 8,
      requisitosIds: const ['r_taller_vj3d', 'r_ing_software'],
      profesorAsignado: profesores[3],
    ),
    Ramo(
      id: 'r_ing_economica',
      nombre: 'Ing. Económica y Evaluación de Proyectos',
      descripcion:
          'Herramientas para evaluar proyectos de ingeniería desde el punto '
          'de vista económico y financiero.',
      creditos: 4,
      requisitosIds: const ['r_seminario_sociedad'],
      profesorAsignado: profesores[8],
    ),
    Ramo(
      id: 'r_seminario_sociedad',
      nombre: 'Seminario Videojuegos y Sociedad',
      descripcion:
          'Análisis crítico del impacto cultural, social y ético de los '
          'videojuegos en la sociedad.',
      creditos: 4,
      requisitosIds: const ['r_modelos_negocio'],
      profesorAsignado: profesores[9],
    ),
  ],

  // Semestre 9 – Año 5
  9: [
    Ramo(
      id: 'r_memoria_titulo',
      nombre: 'Memoria de Título',
      descripcion:
          'Desarrollo, documentación y defensa del trabajo final de titulación '
          'en Ingeniería en Desarrollo de Videojuegos y RV.',
      creditos: 16,
      requisitosIds: const ['r_proy_memoria'],
      profesorAsignado: profesores[3],
    ),
    Ramo(
      id: 'r_aspectos_legales',
      nombre: 'Aspectos Legales y Propiedad Intelectual del Software',
      descripcion:
          'Marco legal relacionado con software, videojuegos y propiedad '
          'intelectual.',
      creditos: 4,
      requisitosIds: const ['r_ing_software'],
      profesorAsignado: profesores[9],
    ),
    Ramo(
      id: 'r_gestion_innovacion',
      nombre: 'Gestión de la Innovación y Emprendimiento',
      descripcion:
          'Herramientas para gestionar innovación y emprender proyectos '
          'tecnológicos en el ámbito de los videojuegos.',
      creditos: 4,
      requisitosIds: const ['r_ing_economica'],
      profesorAsignado: profesores[8],
    ),
  ],
};

/// //Metas de ramos (dificultad, carga horaria, modalidad, tags)

const Map<String, String> dificultadPorRamo = {
  // Semestre 1
  'r_dt': 'Baja–Media',
  'r_intro_vj': 'Media',
  'r_prog_estruct': 'Media–Alta',
  // Semestre 2
  'r_taller_met': 'Media',
  'r_taller_vj1': 'Media',
  'r_prog_objetos': 'Media–Alta',
  // Semestre 3
  'r_prod_2d': 'Media',
  'r_prog_vj2d': 'Media–Alta',
  'r_alg_edd': 'Alta',
  // Semestre 4
  'r_fisica_vj': 'Media–Alta',
  'r_taller_vj2d': 'Media–Alta',
  'r_bd': 'Media',
  // Semestre 5
  'r_diseno_vj': 'Media',
  'r_ia': 'Alta',
  'r_prod_3d': 'Media–Alta',
  'r_fund_comp_graf': 'Alta',
  // Semestre 6
  'r_prog_movil': 'Media–Alta',
  'r_usabilidad': 'Media',
  'r_sisop_redes': 'Alta',
  'r_prog_vj3d': 'Alta',
  'r_vr_avanzada': 'Alta',
  // Semestre 7
  'r_taller_vj3d': 'Alta',
  'r_modelos_negocio': 'Media',
  'r_ing_software': 'Alta',
  // Semestre 8
  'r_proy_memoria': 'Alta',
  'r_ing_economica': 'Media',
  'r_seminario_sociedad': 'Media',
  // Semestre 9
  'r_memoria_titulo': 'Muy alta',
  'r_aspectos_legales': 'Media',
  'r_gestion_innovacion': 'Media–Alta',
};

const Map<String, String> workloadPorRamo = {
  // Semestre 1
  'r_dt': '3–4 h/sem',
  'r_intro_vj': '4–5 h/sem',
  'r_prog_estruct': '6–8 h/sem',
  // Semestre 2
  'r_taller_met': '4–6 h/sem',
  'r_taller_vj1': '4–6 h/sem',
  'r_prog_objetos': '6–8 h/sem',
  // Semestre 3
  'r_prod_2d': '4–6 h/sem',
  'r_prog_vj2d': '6–8 h/sem',
  'r_alg_edd': '6–8 h/sem',
  // Semestre 4
  'r_fisica_vj': '5–7 h/sem',
  'r_taller_vj2d': '5–7 h/sem',
  'r_bd': '4–6 h/sem',
  // Semestre 5
  'r_diseno_vj': '4–6 h/sem',
  'r_ia': '6–8 h/sem',
  'r_prod_3d': '5–7 h/sem',
  'r_fund_comp_graf': '6–8 h/sem',
  // Semestre 6
  'r_prog_movil': '5–7 h/sem',
  'r_usabilidad': '3–4 h/sem',
  'r_sisop_redes': '6–8 h/sem',
  'r_prog_vj3d': '6–8 h/sem',
  'r_vr_avanzada': '6–8 h/sem',
  // Semestre 7
  'r_taller_vj3d': '6–8 h/sem',
  'r_modelos_negocio': '3–4 h/sem',
  'r_ing_software': '6–8 h/sem',
  // Semestre 8
  'r_proy_memoria': '8–10 h/sem',
  'r_ing_economica': '3–4 h/sem',
  'r_seminario_sociedad': '3–4 h/sem',
  // Semestre 9
  'r_memoria_titulo': '10–12 h/sem',
  'r_aspectos_legales': '3–4 h/sem',
  'r_gestion_innovacion': '4–6 h/sem',
};

const Map<String, String> modalidadPorRamo = {
  // Semestre 1
  'r_dt': 'Presencial / Taller',
  'r_intro_vj': 'Presencial',
  'r_prog_estruct': 'Presencial / Laboratorio',
  // Semestre 2
  'r_taller_met': 'Presencial / Taller',
  'r_taller_vj1': 'Presencial / Laboratorio',
  'r_prog_objetos': 'Presencial / Laboratorio',
  // Semestre 3
  'r_prod_2d': 'Presencial / Lab de computación',
  'r_prog_vj2d': 'Presencial / Laboratorio',
  'r_alg_edd': 'Presencial',
  // Semestre 4
  'r_fisica_vj': 'Presencial / Laboratorio',
  'r_taller_vj2d': 'Presencial / Taller',
  'r_bd': 'Presencial / Laboratorio',
  // Semestre 5
  'r_diseno_vj': 'Presencial / Taller',
  'r_ia': 'Presencial / Laboratorio',
  'r_prod_3d': 'Presencial / Lab 3D',
  'r_fund_comp_graf': 'Presencial / Laboratorio',
  // Semestre 6
  'r_prog_movil': 'Presencial / Laboratorio',
  'r_usabilidad': 'Presencial / Taller',
  'r_sisop_redes': 'Presencial / Laboratorio',
  'r_prog_vj3d': 'Presencial / Laboratorio',
  'r_vr_avanzada': 'Presencial / Lab RV',
  // Semestre 7
  'r_taller_vj3d': 'Presencial / Taller de proyecto',
  'r_modelos_negocio': 'Presencial',
  'r_ing_software': 'Presencial',
  // Semestre 8
  'r_proy_memoria': 'Presencial / Trabajo guiado',
  'r_ing_economica': 'Presencial',
  'r_seminario_sociedad': 'Presencial / Seminario',
  // Semestre 9
  'r_memoria_titulo': 'Presencial / Trabajo guiado',
  'r_aspectos_legales': 'Presencial',
  'r_gestion_innovacion': 'Presencial / Taller',
};

const Map<String, List<String>> tagsPorRamo = {
  // Semestre 1
  'r_dt': ['UX/UI', 'Creatividad', 'Trabajo en equipo'],
  'r_intro_vj': ['Industria', 'Panorama general', 'Motores de juego'],
  'r_prog_estruct': ['Lógica', 'C', 'Fundamentos de programación'],
  // Semestre 2
  'r_taller_met': ['Creatividad', 'Metodologías ágiles', 'Proyecto grupal'],
  'r_taller_vj1': ['Prototipos', 'Juegos pequeños', 'Motores básicos'],
  'r_prog_objetos': ['POO', 'Clases', 'Herencia'],
  // Semestre 3
  'r_prod_2d': ['Arte 2D', 'Sprites', 'UI'],
  'r_prog_vj2d': ['Motor 2D', 'Gameplay', 'Física simple'],
  'r_alg_edd': ['Estructuras de datos', 'Algoritmos', 'Optimización'],
  // Semestre 4
  'r_fisica_vj': ['Física', 'Colisiones', 'Simulación'],
  'r_taller_vj2d': ['Proyecto 2D', 'Diseño de niveles', 'Trabajo en equipo'],
  'r_bd': ['SQL', 'Modelo relacional', 'Persistencia'],
  // Semestre 5
  'r_diseno_vj': ['Mecánicas', 'Balance', 'Experiencia de juego'],
  'r_ia': ['IA en juegos', 'Pathfinding', 'Agentes'],
  'r_prod_3d': ['Modelado 3D', 'Texturas', 'Assets'],
  'r_fund_comp_graf': ['Rendering', 'Shaders', 'Pipeline gráfico'],
  // Semestre 6
  'r_prog_movil': ['Apps móviles', 'Rendimiento', 'Input táctil'],
  'r_usabilidad': ['UX', 'Accesibilidad', 'Testing'],
  'r_sisop_redes': ['Procesos', 'Sockets', 'Redes'],
  'r_prog_vj3d': ['Motor 3D', 'Cámaras', 'Física 3D'],
  'r_vr_avanzada': ['VR', 'Inmersión', 'Interacción espacial'],
  // Semestre 7
  'r_taller_vj3d': ['Proyecto grande', 'Equipo', 'Gestión'],
  'r_modelos_negocio': ['Monetización', 'Mercado', 'Publicación'],
  'r_ing_software': ['Patrones', 'Procesos', 'Calidad'],
  // Semestre 8
  'r_proy_memoria': ['Investigación', 'Proyecto largo', 'Titulación'],
  'r_ing_economica': ['Flujos de caja', 'Evaluación de proyectos'],
  'r_seminario_sociedad': ['Ética', 'Impacto social', 'Cultura gamer'],
  // Semestre 9
  'r_memoria_titulo': ['Tesis', 'Defensa', 'Proyecto final'],
  'r_aspectos_legales': ['Derechos de autor', 'Licencias', 'Contratos'],
  'r_gestion_innovacion': ['Emprendimiento', 'Startups', 'Innovación'],
};

/// Modelo de evaluación por ramo
class EvalItem {
  final String label;
  final int percent; // 0–100

  const EvalItem({required this.label, required this.percent});
}

const Map<String, List<EvalItem>> evalPorRamo = {
  // Semestre 1
  'r_dt': [
    EvalItem(label: 'Proyecto grupal', percent: 40),
    EvalItem(label: 'Entrega de prototipos', percent: 30),
    EvalItem(label: 'Controles', percent: 30),
  ],
  'r_intro_vj': [
    EvalItem(label: 'Proyecto corto de juego', percent: 40),
    EvalItem(label: 'Pruebas teóricas', percent: 40),
    EvalItem(label: 'Tareas', percent: 20),
  ],
  'r_prog_estruct': [
    EvalItem(label: 'Laboratorios de programación', percent: 40),
    EvalItem(label: 'Pruebas de código', percent: 40),
    EvalItem(label: 'Tareas individuales', percent: 20),
  ],

  // Semestre 2
  'r_taller_met': [
    EvalItem(label: 'Proyecto final', percent: 50),
    EvalItem(label: 'Bitácora / entregas', percent: 30),
    EvalItem(label: 'Participación', percent: 20),
  ],
  'r_taller_vj1': [
    EvalItem(label: 'Juego final', percent: 50),
    EvalItem(label: 'Entregas parciales', percent: 30),
    EvalItem(label: 'Controles teóricos', percent: 20),
  ],
  'r_prog_objetos': [
    EvalItem(label: 'Laboratorios', percent: 40),
    EvalItem(label: 'Pruebas', percent: 40),
    EvalItem(label: 'Tareas', percent: 20),
  ],

  // Semestre 3
  'r_prod_2d': [
    EvalItem(label: 'Portfolio de arte 2D', percent: 50),
    EvalItem(label: 'Tareas técnicas', percent: 30),
    EvalItem(label: 'Controles', percent: 20),
  ],
  'r_prog_vj2d': [
    EvalItem(label: 'Proyecto 2D', percent: 50),
    EvalItem(label: 'Laboratorios', percent: 30),
    EvalItem(label: 'Prueba teórica', percent: 20),
  ],
  'r_alg_edd': [
    EvalItem(label: 'Pruebas escritas', percent: 50),
    EvalItem(label: 'Laboratorios', percent: 30),
    EvalItem(label: 'Tareas', percent: 20),
  ],

  // Semestre 4
  'r_fisica_vj': [
    EvalItem(label: 'Laboratorios de simulación', percent: 40),
    EvalItem(label: 'Pruebas', percent: 40),
    EvalItem(label: 'Tareas', percent: 20),
  ],
  'r_taller_vj2d': [
    EvalItem(label: 'Proyecto 2D final', percent: 60),
    EvalItem(label: 'Entregas intermedias', percent: 25),
    EvalItem(label: 'Auto/coevaluación', percent: 15),
  ],
  'r_bd': [
    EvalItem(label: 'Proyecto BD', percent: 40),
    EvalItem(label: 'Pruebas SQL', percent: 40),
    EvalItem(label: 'Tareas', percent: 20),
  ],

  // Semestre 5
  'r_diseno_vj': [
    EvalItem(label: 'Documento de diseño', percent: 40),
    EvalItem(label: 'Presentaciones', percent: 30),
    EvalItem(label: 'Ejercicios de diseño', percent: 30),
  ],
  'r_ia': [
    EvalItem(label: 'Proyecto IA en juego', percent: 40),
    EvalItem(label: 'Pruebas teórico–prácticas', percent: 40),
    EvalItem(label: 'Tareas', percent: 20),
  ],
  'r_prod_3d': [
    EvalItem(label: 'Portfolio 3D', percent: 60),
    EvalItem(label: 'Tareas técnicas', percent: 25),
    EvalItem(label: 'Controles', percent: 15),
  ],
  'r_fund_comp_graf': [
    EvalItem(label: 'Laboratorios / demos', percent: 40),
    EvalItem(label: 'Prueba teórica', percent: 40),
    EvalItem(label: 'Tareas breves', percent: 20),
  ],

  // Semestre 6
  'r_prog_movil': [
    EvalItem(label: 'App / juego móvil', percent: 50),
    EvalItem(label: 'Laboratorios', percent: 30),
    EvalItem(label: 'Prueba', percent: 20),
  ],
  'r_usabilidad': [
    EvalItem(label: 'Proyecto de evaluación UX', percent: 40),
    EvalItem(label: 'Informes de pruebas', percent: 40),
    EvalItem(label: 'Participación', percent: 20),
  ],
  'r_sisop_redes': [
    EvalItem(label: 'Laboratorios', percent: 40),
    EvalItem(label: 'Pruebas', percent: 40),
    EvalItem(label: 'Tareas', percent: 20),
  ],
  'r_prog_vj3d': [
    EvalItem(label: 'Proyecto 3D jugable', percent: 50),
    EvalItem(label: 'Laboratorios', percent: 30),
    EvalItem(label: 'Prueba', percent: 20),
  ],
  'r_vr_avanzada': [
    EvalItem(label: 'Experiencia VR', percent: 50),
    EvalItem(label: 'Entregas técnicas', percent: 30),
    EvalItem(label: 'Informe / demo', percent: 20),
  ],

  // Semestre 7
  'r_taller_vj3d': [
    EvalItem(label: 'Proyecto 3D grande', percent: 60),
    EvalItem(label: 'Hitos del proyecto', percent: 25),
    EvalItem(label: 'Auto/coevaluación', percent: 15),
  ],
  'r_modelos_negocio': [
    EvalItem(label: 'Proyecto de negocio', percent: 40),
    EvalItem(label: 'Controles', percent: 30),
    EvalItem(label: 'Presentaciones', percent: 30),
  ],
  'r_ing_software': [
    EvalItem(label: 'Proyecto de software', percent: 50),
    EvalItem(label: 'Pruebas', percent: 30),
    EvalItem(label: 'Tareas / quices', percent: 20),
  ],

  // Semestre 8
  'r_proy_memoria': [
    EvalItem(label: 'Informe escrito', percent: 40),
    EvalItem(label: 'Avances y presentaciones', percent: 40),
    EvalItem(label: 'Planificación', percent: 20),
  ],
  'r_ing_economica': [
    EvalItem(label: 'Proyecto de evaluación', percent: 40),
    EvalItem(label: 'Pruebas', percent: 40),
    EvalItem(label: 'Tareas', percent: 20),
  ],
  'r_seminario_sociedad': [
    EvalItem(label: 'Ensayo / informe', percent: 40),
    EvalItem(label: 'Presentaciones', percent: 30),
    EvalItem(label: 'Participación', percent: 30),
  ],

  // Semestre 9
  'r_memoria_titulo': [
    EvalItem(label: 'Documento final', percent: 50),
    EvalItem(label: 'Defensa oral', percent: 30),
    EvalItem(label: 'Proceso / avances', percent: 20),
  ],
  'r_aspectos_legales': [
    EvalItem(label: 'Estudio de casos', percent: 40),
    EvalItem(label: 'Pruebas', percent: 40),
    EvalItem(label: 'Tareas', percent: 20),
  ],
  'r_gestion_innovacion': [
    EvalItem(label: 'Proyecto de emprendimiento', percent: 50),
    EvalItem(label: 'Pitch / presentación', percent: 30),
    EvalItem(label: 'Tareas / ejercicios', percent: 20),
  ],
};

//Comentarios de estudiantes sobre profesores

class StudentComment {
  final String author;
  final String detail;
  final String text;
  final String when;
  final double rating;

  const StudentComment({
    required this.author,
    required this.detail,
    required this.text,
    required this.when,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
    'author': author,
    'detail': detail,
    'text': text,
    'when': when,
    'rating': rating,
  };

  factory StudentComment.fromJson(Map<String, dynamic> json) => StudentComment(
    author: json['author'] ?? '',
    detail: json['detail'] ?? '',
    text: json['text'] ?? '',
    when: json['when'] ?? '',
    rating: (json['rating'] ?? 0).toDouble(),
  );
}

const Map<String, List<StudentComment>> dummyCommentsByProf = {
  'p1': [
    StudentComment(
      author: 'Camila',
      detail: '3er año · IDVRV',
      text: 'Explica con calma y siempre responde dudas fuera de clase.',
      when: 'hace 2 semanas',
      rating: 4.8,
    ),
    StudentComment(
      author: 'Tomás',
      detail: '2º año · IDVRV',
      text:
          'Sus evaluaciones son exigentes, pero muy alineadas con lo que enseña.',
      when: 'hace 1 mes',
      rating: 4.5,
    ),
    StudentComment(
      author: 'Ignacio',
      detail: '2º año · IDVRV',
      text:
          'Da buenos ejemplos de proyectos y se preocupa del trabajo en grupo.',
      when: 'hace 3 meses',
      rating: 4.6,
    ),
  ],
  'p2': [
    StudentComment(
      author: 'Valentina',
      detail: '1er año · IDVRV',
      text: 'Me ayudó a mejorar muchísimo la forma de escribir historias.',
      when: 'hace 3 semanas',
      rating: 5.0,
    ),
    StudentComment(
      author: 'Matías',
      detail: '1er año · IDVRV',
      text:
          'Sus rúbricas son claras y deja tiempo para revisar los guiones con él.',
      when: 'hace 2 meses',
      rating: 4.7,
    ),
  ],
  'p3': [
    StudentComment(
      author: 'Jorge',
      detail: '3er año · IDVRV',
      text: 'Clases muy claras, pero hay que practicar harto por fuera.',
      when: 'hace 5 días',
      rating: 4.3,
    ),
    StudentComment(
      author: 'Nicole',
      detail: '2º año · IDVRV',
      text:
          'Responde correos rápido y siempre da tips para ordenar mejor el código.',
      when: 'hace 1 mes',
      rating: 4.6,
    ),
  ],
  'p4': [
    StudentComment(
      author: 'Sebastián',
      detail: '3er año · IDVRV',
      text:
          'Muestra ejemplos reales con Unity y Unreal, se nota la experiencia que tiene.',
      when: 'hace 1 semana',
      rating: 4.9,
    ),
    StudentComment(
      author: 'Antonia',
      detail: '3er año · IDVRV',
      text:
          'Es exigente, pero uno sale del ramo con otra mentalidad de programación.',
      when: 'hace 1 mes',
      rating: 4.7,
    ),
  ],
  'p5': [
    StudentComment(
      author: 'Diego',
      detail: '2º año · IDVRV',
      text:
          'Explica la física con ejemplos de juegos, eso hace todo mucho más entendible.',
      when: 'hace 3 semanas',
      rating: 4.5,
    ),
    StudentComment(
      author: 'Francisca',
      detail: '2º año · IDVRV',
      text:
          'Sus guías de ejercicios ayudan harto para preparar las evaluaciones.',
      when: 'hace 2 meses',
      rating: 4.4,
    ),
  ],
  'p6': [
    StudentComment(
      author: 'Paula',
      detail: '2º año · IDVRV',
      text:
          'Da muy buen feedback sobre paletas de color y composición de pantallas.',
      when: 'hace 6 días',
      rating: 4.8,
    ),
    StudentComment(
      author: 'Leonardo',
      detail: '3er año · IDVRV',
      text: 'Siempre comparte recursos y referencias para mejorar el arte 2D.',
      when: 'hace 1 mes',
      rating: 4.6,
    ),
  ],
  'p7': [
    StudentComment(
      author: 'Gabriela',
      detail: '3er año · IDVRV',
      text:
          'Ayuda mucho a optimizar modelos para VR, explica bien los LOD y el bakeo.',
      when: 'hace 2 semanas',
      rating: 4.7,
    ),
    StudentComment(
      author: 'Cristóbal',
      detail: '4º año · IDVRV',
      text:
          'Sus correcciones en los proyectos 3D son detalladas, pero se aprende harto.',
      when: 'hace 2 meses',
      rating: 4.5,
    ),
  ],
  'p8': [
    StudentComment(
      author: 'Isidora',
      detail: '3er año · IDVRV',
      text:
          'Explica los conceptos de hilos y sockets con ejemplos aplicados a juegos online.',
      when: 'hace 1 mes',
      rating: 4.4,
    ),
    StudentComment(
      author: 'Felipe',
      detail: '3er año · IDVRV',
      text:
          'Las pruebas son difíciles, pero si uno sigue las guías llega bien preparado.',
      when: 'hace 3 meses',
      rating: 4.2,
    ),
  ],
  'p9': [
    StudentComment(
      author: 'Rocío',
      detail: '4º año · IDVRV',
      text:
          'Te hace pensar el proyecto como negocio real, no solo como juego entretenido.',
      when: 'hace 2 semanas',
      rating: 4.6,
    ),
    StudentComment(
      author: 'Mauricio',
      detail: '4º año · IDVRV',
      text:
          'Sus comentarios sobre los pitch son súper honestos, pero ayudan a mejorar.',
      when: 'hace 1 mes',
      rating: 4.5,
    ),
  ],
  'p10': [
    StudentComment(
      author: 'Daniela',
      detail: '4º año · IDVRV',
      text:
          'Aporta otra mirada sobre el impacto social de los juegos, las discusiones son buenas.',
      when: 'hace 3 semanas',
      rating: 4.7,
    ),
    StudentComment(
      author: 'Andrés',
      detail: '5º año · IDVRV',
      text:
          'Aclara muy bien los temas de licencias y propiedad intelectual para proyectos de título.',
      when: 'hace 2 meses',
      rating: 4.6,
    ),
  ],
};
