
# EduProf

-Es una aplicación diseñada como herramienta de apoyo para los estudiantes de la carrera de Ingeniería en Desarrollo de Videojuegos y Realidad Virtual.
Su objetivo principal es organizar la información académica de manera clara y accesible, permitiendo consultar semestres, profesores y la malla curricular de forma centralizada.


## Características Principales

### Menú Principal
- Barra de navegación inferior con 2 opciones: Inicio y Buscar.

### Página de Inicio
- Mensaje principal: "Bienvenido a EduProf".

- Dos accesos directos en forma de tarjetas:

      Semestres → lista de semestres disponibles.

      -Profesores → catálogo de docentes con sus detalles.

- Imagen de la malla curricular con opción de ampliarla en pantalla completa.

### Semestres
- Grid con los 9 semestres de la carrera.

- Cada semestre despliega una lista de ramos (asignaturas).

- En cada ramo se muestra:

      -Nombre

      -Descripción

      -Créditos

      -Requisitos (si los hay)

      -Profesor asignado (con acceso a su detalle).

### Profesores
- Listado organizado por ramos.

- Cada profesor muestra:

      -Foto (o iniciales en un ícono si no hay imagen).

      -Nombre

      -Horario de atención

      -Ubicación de oficina

      -Bibliografía / correo de contacto.

### Malla Curricular
- Vista previa en la página de inicio.

- Opción de abrirla a pantalla completa con zoom y desplazamiento.

## Pila de la aplicación 
**Client:** Flutter y Android.

## Video de presentación
https://youtu.be/3h7XuvXUp2Q



flowchart TD
  L([App Start]) --> H[Home / Dashboard]

  %% Acciones disponibles en Home
  H -->|tap "Semestres"| SEM[Semestres]
  H -->|tap "Profesores"| PROFS[Profesores]
  H -->|tap icono "expandir malla"| MALLA[Malla Full Screen]
  H -->|tab "Buscar"| SEARCH[Buscar (placeholder)]
  H -->|tab "Favoritos"| FAV[Favoritos (placeholder)]

  %% Flujo Semestres -> Ramo -> Profesor
  SEM -->|select "Sem N"| SDET[Semestre Detalle]
  SDET -->|tap "Ramo"| RDET[Ramo Detalle]
  RDET -->|tap "Profesor asignado"| PDET[Profesor Detalle]

  %% Flujo Profesores -> Detalle
  PROFS -->|tap tarjeta| PDET2[Profesor Detalle]

  %% Regresos (back)
  PDET --> RDET
  RDET --> SDET
  SDET --> SEM
  SEM -. back .-> H
  PROFS -. back .-> H
  MALLA -. back .-> H
  SEARCH -. tab back .-> H
  FAV -. tab back .-> H
