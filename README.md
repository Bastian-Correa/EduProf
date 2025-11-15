# 📘 EduProf — Prototipo Funcional Móvil

**EduProf** es una aplicación móvil desarrollada en **Flutter** cuyo propósito es apoyar a los estudiantes de la carrera de *Ingeniería en Desarrollo de Videojuegos y Realidad Virtual* en la consulta rápida y organizada de información académica: semestres, ramos, profesores y malla curricular.

Incluye funcionalidades avanzadas como búsqueda, sistema de favoritos, personalización visual y un módulo de validación con preguntas cargadas dinámicamente desde JSON.

---

## Características Principales

### 🏠 Página de Inicio
La pantalla principal incluye:
- Mensaje de bienvenida.
- Hero banner informativo.
- Selector de pestañas:
  - **Ramos**
  - **Profesores**
- Accesos directos a:
  - Explorar por semestres  
  - Mis ramos favoritos  
  - Listado de profesores  
  - Profesores favoritos  
- Miniatura de la **malla curricular**, con vista ampliada mediante zoom.

---

## Semestres y Ramos
- Grid con los **9 semestres** de la carrera.
- Cada semestre muestra su lista de ramos.
- Cada ramo contiene:
  - Nombre  
  - Descripción  
  - Créditos  
  - Requisitos  
  - Modalidad  
  - Nivel de dificultad  
  - Carga de trabajo semanal  
  - Evaluación del ramo (JSON interno)  
  - Profesor asociado  
- Opción de **agregar o quitar de favoritos**, usando SharedPreferences.

---

## Profesores
Cada profesor contiene:
- Imagen o iniciales  
- Nombre completo  
- Horario de atención  
- Ubicación de oficina  
- Correo institucional  
- Años de experiencia 
- Lista de ramos que imparte 
- Sección de comentarios simulados 
- Botón de favoritos con persistencia local  

---

## Favoritos
Pantalla con dos pestañas:
- **Ramos favoritos**  
- **Profesores favoritos**

---

## Búsqueda Avanzada
Pantalla dedicada para buscar:
- Ramos  
- Profesores  
- Modo “Todo”

Incluye:
- Campo de texto  
- Filtros tipo “chips”  
- Búsqueda insensible a acentos y mayúsculas  
- Acceso directo al detalle del elemento seleccionado  

---

## Preferencias del Usuario
Desde el menú de configuración, el usuario puede personalizar:

### Color del tema
- 4 colores disponibles.

### Tipo de letra
- Predeterminada  
- Sans personalizada  
- Serif personalizada  
- Rounded personalizada  

### Tamaño del texto
- Normal  
- Grande  


---

## Validación de Usuarios (Encuesta)
En la pantalla **Acerca de EduProf** existe el botón:

### “Calificar la app”

Este abre la pantalla de validación, que contiene:
- Campo de texto obligatorio: **nombre del usuario**
- Preguntas cargadas dinámicamente desde:

- Sistema de calificación de 1 a 5 estrellas por pregunta  
- Botón para **Enviar respuestas**

Al enviar:
- Se valida que el nombre no esté vacío  
- Se genera un resumen con todas las respuestas  
- Se abre el cliente de correo del dispositivo con mensaje prellenado dirigido a: bcorrea23@alumnos.utalca.cl

---

# Diagrama de flujo – Caso de uso principal de EduProf

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
  RamoDetalle[RamoDetalle: información del ramo y profesor]
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

  %% --- Favoritos ---
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

  %% --- Fin ---
  FP1 --> EndFlow([Fin del caso de uso])
  EndFlow

