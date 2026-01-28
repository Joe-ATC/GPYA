# Blueprint: Aplicación de Documentación Legal

## 1. Visión General
Crear una aplicación móvil para iOS, Android y web que permita a los usuarios de la firma visualizar y descargar documentación legal esencial. La app debe proyectar una imagen de modernidad, seguridad y elegancia, con una identidad visual audaz y funciones de mantenimiento accesibles para el usuario.

## 2. Diseño y Estilo (UI/UX) - "Rojo Corporativo y Claridad Cristalina"
*   **Paleta de Colores:** Se utiliza un tema oscuro (`primaryBlack`) con un rojo corporativo (`accentRed`) como color de acento para todos los elementos interactivos, proyectando una imagen enérgica y profesional.
*   **Tipografía:** Se mantiene la fuente `Montserrat` de Google Fonts para una legibilidad y elegancia consistentes.
*   **Fondo:** Se conserva el fondo de degradado radial oscuro que va desde un gris superficie (`surface`) hasta el negro puro, creando una sensación de profundidad.
*   **Tarjetas:** La pantalla de "Documentos" utiliza tarjetas con efecto de "cristal esmerilado" (`BackdropFilter`) para una apariencia moderna y sofisticada.
*   **Icono de la App:** Se ha configurado `flutter_launcher_icons` para generar automáticamente los iconos de la aplicación para todas las plataformas (Android, iOS, web) a partir de un único archivo de origen.

## 3. Arquitectura y Funcionalidad
*   **Navegación:** La aplicación se estructura en torno a una `BottomNavigationBar` con cuatro secciones principales: Inicio, Documentos, Servicios y Ajustes. Se usa un `IndexedStack` para mantener el estado de cada pantalla al navegar.
*   **Gestión de Estado (Sincronización):** Se utiliza una `GlobalKey` para permitir la comunicación entre la pantalla de "Ajustes" y la de "Documentos", permitiendo que la primera pueda invocar un método público (`refreshDocuments`) en la segunda para forzar una recarga de datos.
*   **Backend:** Supabase sigue siendo el backend para la obtención de la lista de documentos.
*   **Funcionalidades de Ajustes:**
    *   **Sincronizar Datos:** Recarga la lista de documentos desde Supabase.
    *   **Limpiar Caché:** Elimina archivos temporales de la aplicación usando `path_provider`.
    *   **Gestionar Permisos:** Abre la pantalla de configuración de permisos de la app en el sistema operativo del dispositivo a través de `permission_handler`.

## 4. Plan de Implementación (Últimas Mejoras)

1.  **Corregir Descargas en Android:** Se eliminó la lógica de solicitud de permisos (`permission_handler`) que era redundante y causaba fallos en versiones modernas de Android, simplificando el flujo de descarga. *(Completado)*
2.  **Cambio de Paleta de Colores:** Se actualizó `main.dart` para reemplazar el color de acento dorado por un rojo corporativo (`#D32F2F`). *(Completado)*
3.  **Implementar Pantalla de Ajustes:**
    *   Se reescribió `lib/screens/settings_screen.dart` para incluir las opciones de Sincronizar, Limpiar Caché y Gestionar Permisos, usando `ListTile`s para una UI clara. *(Completado)*
    *   Se añadió el método `refreshDocuments()` a `lib/screens/dashboard_screen.dart` y se hizo accesible mediante una `GlobalKey`. *(Completado)*
4.  **Configurar Icono de la Aplicación:**
    *   Se añadió el paquete `flutter_launcher_icons` a `pubspec.yaml`. *(Completado)*
    *   Se configuró el `pubspec.yaml` para definir la ruta de la imagen del icono y las opciones de generación para Android, iOS y web. *(Completado)*
    *   Se instruyó al usuario para colocar el `icon.png` y ejecutar el comando de generación. *(Completado)*
5.  **Poblar Pantalla de Inicio:** **(Pendiente)** A la espera de que el usuario proporcione el texto de la web `https://azure-stingray-462195.hostingersite.com/`.

