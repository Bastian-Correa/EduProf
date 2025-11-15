
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



## Diagrama de flujo – Caso de uso principal de EduProf

 **Fuente de Datos:** archivo academico.dart que centraliza la información de ramos y profesores, utilizando las estructuras definidas en profesor.dart y ramo.dart para su organización (Para que se entienda mejor a donde esta la base de datos)

```mermaid
flowchart TD

  %% --- Inicio ---
  A([Inicio]) --> B[Usuario abre la app EduProf]
  B --> C[La app carga preferencias visuales]
  C --> D[Pantalla de inicio con malla por semestres]

  %% --- Decisión principal ---
  D --> E{¿Usar búsqueda o navegar por semestre?}

  %% --- Rama Semestres ---
  E -- Navegar por semestre --> S1[Usuario selecciona un semestre]
  S1 --> S2[Se muestran los ramos del semestre]
  S2 --> S3[Usuario selecciona un ramo]
  S3 --> RamoDetalle

  %% --- Rama Búsqueda ---
  E -- Usar búsqueda --> B1[Usuario abre pantalla de búsqueda]
  B1 --> B2[Campo de texto y filtros]
  B2 --> B3[Usuario escribe texto y elige filtro]
  B3 --> B4[La app muestra resultados filtrados]
  B4 --> B5{¿Resultado es ramo o profesor?}
  B5 -- Ramo --> RamoDetalle
  B5 -- Profesor --> ProfesorDetalle

  %% --- Detalle de Ramo ---
  RamoDetalle[RamoDetalle: info del ramo y profesor]
  RamoDetalle --> FR{¿Marcar como favorito?}
  FR -- Sí --> FSaveR[Guardar en favoritos]
  FR -- No --> FP1[Seguir navegando]

  RamoDetalle --> DR{¿Abrir detalle del profesor?}
  DR -- Sí --> ProfesorDetalle
  DR -- No --> FP1

  %% --- Detalle Profesor ---
  ProfesorDetalle[Detalle del profesor: datos y comentarios]
  ProfesorDetalle --> FP{¿Marcar como favorito?}
  FP -- Sí --> FSaveP[Guardar en favoritos]
  FP -- No --> EndFlow

  %% --- Favoritos (flujo alternativo) ---
  D --> FAV1[Usuario entra a Favoritos]
  FAV1 --> FAV2[Pestañas Ramos y Profesores]
  FAV2 --> FAV3[Selecciona un favorito]
  FAV3 --> FAV4{¿Es ramo o profesor?}
  FAV4 -- Ramo --> RamoDetalle
  FAV4 -- Profesor --> ProfesorDetalle

  %% --- Acerca de + Validación ---
  D --> AC1[Usuario abre pantalla Acerca de]
  AC1 --> AC2[Botón Calificar la app]
  AC2 --> VAL1[Pantalla de Validación]
  VAL1 --> VAL2[Usuario escribe su nombre]
  VAL1 --> VAL3[Usuario califica con estrellas]
  VAL3 --> VAL4[La app genera resumen]
  VAL4 --> VAL5[Se abre correo prellenado]

  %% --- Fin del caso de uso ---
  FP1 --> EndFlow([Fin del caso de uso])
  EndFlow



 