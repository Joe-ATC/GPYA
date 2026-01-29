# GPYA - Aplicación de Documentación Legal

Aplicación móvil para iOS y Android que permite a los usuarios visualizar y descargar documentación legal esencial. La app proyecta una imagen de modernidad, seguridad y elegancia, con una identidad visual audaz y funciones de mantenimiento accesibles para el usuario.

---

## 📋 Características Principales

- **Interfaz Moderna y Elegante:**
  - Tema oscuro con acentos en rojo corporativo.
  - Tipografía profesional con Google Fonts (`Montserrat`).
  - Fondos con degradado y tarjetas con efecto "Glassmorphism" (cristal esmerilado).
  - Iconos de aplicación personalizados para todas las plataformas.

- **Backend Robusto con Supabase:**
  - Conexión a una base de datos PostgreSQL para obtener la lista de documentos.
  - La configuración está centralizada en `lib/main.dart` para un fácil mantenimiento.

- **Funcionalidad Orientada al Usuario:**
  - Descarga de documentos con seguimiento de progreso.
  - Apertura de archivos descargados directamente desde la app.
  - Sincronización de datos bajo demanda.
  - Limpieza de caché de la aplicación.

- **Multiplataforma (Mobile First):**
  - Código base único de Flutter para Android e iOS.
  - Preparado para compilación nativa en ambas plataformas.

---

## 🛠️ Pre-requisitos de Software

Antes de empezar, asegúrate de tener instalado el siguiente software en tu máquina:

1.  **Flutter SDK:** [Guía de Instalación Oficial](https://docs.flutter.dev/get-started/install)
2.  **Git:** Para clonar el repositorio.
3.  **Un Editor de Código:** Se recomienda **Visual Studio Code** (con la extensión de Flutter) o **Android Studio**.
4.  **Xcode:** (Solo para desarrollo y compilación en macOS/iOS).

---

## 🚀 Guía de Instalación y Ejecución

Sigue estos pasos para poner el proyecto en marcha en tu máquina local.

### 1. Clonar el Repositorio

Abre tu terminal, navega a tu directorio de trabajo y clona el repositorio de GitHub.

```bash
git clone https://github.com/Joe-ATC/GPYA.git
```

### 2. Entrar al Directorio del Proyecto

```bash
cd GPYA
```

### 3. Instalar Dependencias

Este comando descargará todas las librerías de Flutter necesarias para el proyecto (Supabase, Dio, etc.).

```bash
flutter pub get
```

### 4. Verificar la Instalación (Opcional pero Recomendado)

Ejecuta `flutter doctor` para asegurarte de que tu entorno de desarrollo no tiene problemas.

```bash
flutter doctor
```

### 5. Ejecutar la Aplicación

- Asegúrate de tener un emulador corriendo o un dispositivo físico conectado.
- Ejecuta el siguiente comando:

```bash
flutter run
```

---

## 🍏 Instrucciones Específicas para iOS (en macOS)

Después de seguir los pasos 1, 2 y 3 en tu Mac, hay algunos pasos adicionales:

1.  **Instalar Dependencias de CocoaPods:**
    ```bash
    cd ios
    pod install
    cd ..
    ```

2.  **Abrir el Proyecto en Xcode:**
    Es crucial abrir el archivo `.xcworkspace`, no el `.xcodeproj`.
    ```bash
    open ios/Runner.xcworkspace
    ```

3.  **Configurar la Firma de Código:**
    - Dentro de Xcode, selecciona `Runner` en el navegador de archivos de la izquierda.
    - Ve a la pestaña `Signing & Capabilities`.
    - En la sección `Team`, selecciona tu cuenta de Desarrollador de Apple.

4.  **Ejecutar desde Xcode:**
    Selecciona tu simulador de iPhone o dispositivo físico y presiona el botón de **Play (▶️)**.
