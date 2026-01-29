# Blueprint: Aplicación de Documentación Legal

## 1. Visión General
Crear una aplicación móvil para iOS, Android y web que permita a los usuarios de la firma visualizar y descargar documentación legal esencial. La app debe proyectar una imagen de modernidad, seguridad y elegancia, con una identidad visual audaz y funciones de mantenimiento accesibles para el usuario.

## 2. Diseño y Estilo (UI/UX) - "Rojo Corporativo y Claridad Cristalina"
*   **Paleta de Colores:** La aplicación utiliza un tema oscuro por defecto, con un rojo corporativo (`#D32F2F`) como color de acento. Se ha implementado un `ThemeProvider` para permitir al usuario cambiar entre modo oscuro, claro y del sistema.
*   **Tipografía:** Se mantiene la fuente `Montserrat` de Google Fonts para una legibilidad y elegancia consistentes.
*   **Fondo:** El fondo de la app se adapta al tema seleccionado (oscuro o claro).
*   **Tarjetas:** Las pantallas utilizan `Card`s con una ligera elevación para organizar el contenido de forma modular y moderna.
*   **Icono de la App:** Se ha configurado `flutter_launcher_icons` para generar automáticamente los iconos de la aplicación para todas las plataformas.

## 3. Arquitectura y Funcionalidad
*   **Navegación:** Se utiliza `go_router` con un `StatefulNavigationShell` para una navegación persistente entre las cuatro secciones principales.
*   **Gestión de Estado:** `flutter_riverpod` es el principal gestor de estado, utilizado para la obtención de datos (`documents_provider`) y la gestión del tema de la aplicación (`theme_provider`).
*   **Backend:** Supabase se utiliza para la autenticación y el almacenamiento y obtención de la lista de documentos.

## 4. Historial de Implementación
*   **Corrección de Errores y Advertencias:** Se solucionaron todos los problemas de análisis estático reportados por `flutter analyze`. *(Completado)*
*   **Configuración de Identidad Visual:** Se definió la paleta de colores, tipografía y se generó el icono de la app. *(Completado)*
*   **Implementación de Pantalla de Ajustes (v1):** Se creó una estructura básica para la pantalla de ajustes. *(Reemplazado)*
*   **Rediseño y Población de Pantalla de Inicio:** Se transformó la `HomeScreen` en una sección de bienvenida informativa. *(Completado)*
*   **Construcción de la Pantalla de Servicios:** Se creó una pantalla para listar detalladamente los servicios de la empresa. *(Completado)*
*   **Implementación de la Pantalla de Ajustes Funcional:** Se rediseñó la pantalla, se implementó el cambio de tema (claro/oscuro/sistema) con persistencia y se pulió la lógica de cierre de sesión. *(Completado)*

## 5. Plan de Implementación (Completado)

¡Todas las tareas planificadas han sido completadas con éxito! La aplicación cuenta con todas las funcionalidades y el diseño visual definidos en este blueprint.
