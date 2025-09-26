
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
  %% Pantallas principales de EduProf
  Home["Home"]
  Semestres["Semestres"]
  SemestreDetalle["SemestreDetalle"]
  RamoDetalle["RamoDetalle"]
  Profesores["Profesores"]
  ProfesorDetalle["ProfesorDetalle"]
  BarraNav["BarraNavegación"]
  Malla["Malla (Fullscreen)"]
  Buscar["Buscar (Futuro)"]
  Favoritos["Favoritos (Futuro)"]
  FuenteDeDatos["Fuente de Datos"]

  %% Transiciones lógicas
  Home --> Semestres
  Home --> Profesores
  Home --> Buscar
  Home --> Favoritos
  Home --> Malla

  Semestres --> SemestreDetalle
  SemestreDetalle --> RamoDetalle
  RamoDetalle --> ProfesorDetalle

  Profesores --> ProfesorDetalle

  %% Barra de navegación siempre lleva a Home
  BarraNav -- "Vuelve a -->" --> Home

  %% Conexiones a fuente de datos (opcional, para clarificar relación)
  Semestres -.-> FuenteDeDatos
  Profesores -.-> FuenteDeDatos
  SemestreDetalle -.-> FuenteDeDatos
  RamoDetalle -.-> FuenteDeDatos
  ProfesorDetalle -.-> FuenteDeDatos

  **Fuente de Datos:** archivo academico.dart que centraliza la información de ramos y profesores, utilizando las estructuras definidas en profesor.dart y ramo.dart para su organización (Para que se entienda mejor a donde esta la base de datos)