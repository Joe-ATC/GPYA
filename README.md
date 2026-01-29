# README: Guía Completa del Proyecto Flutter

Este documento proporciona una guía detallada para configurar, ejecutar, y construir la aplicación Flutter desarrollada. El objetivo es asegurar que cualquier desarrollador pueda poner en marcha el proyecto en su máquina local (Windows, macOS, o Linux) sin fricciones, especialmente usando Visual Studio Code.

---

## 📋 Requisitos Previos

Antes de empezar, asegúrate de tener instalado y configurado lo siguiente en tu sistema:

1.  **Flutter SDK:** [Instrucciones de Instalación de Flutter](https://flutter.dev/docs/get-started/install)
2.  **Visual Studio Code:** [Descargar VS Code](https://code.visualstudio.com/)
3.  **Extensiones de VS Code:**
    *   `Flutter` (imprescindible para el desarrollo con Flutter).
    *   `Dart` (generalmente se instala con la extensión de Flutter).

---

## 🚀 Cómo Ejecutar el Proyecto en VS Code (Modo Desarrollo)

Sigue estos pasos para ejecutar la aplicación en un emulador o en tu dispositivo físico.

1.  **Clonar el Repositorio:**
    
    Abre una terminal y clona este repositorio en tu máquina local:
    
    ```bash
    git clone https://github.com/Joe-ATC/GPYA.git
    ```
    
2.  **Abrir en VS Code:**
    
    Abre la carpeta del proyecto recién clonado en Visual Studio Code.
    
    ```bash
    cd GPYA
    code .
    ```
    
3.  **Instalar Dependencias:**
    
    VS Code podría notificarte automáticamente para que instales las dependencias. Si no es así, abre la terminal integrada de VS Code (`Ctrl + ñ` o `View > Terminal`) y ejecuta:
    
    ```bash
    flutter pub get
    ```
    
4.  **Seleccionar un Dispositivo:**
    
    En la esquina inferior derecha de la barra de estado de VS Code, verás el dispositivo seleccionado (ej. `Chrome (web)`). Haz clic ahí para seleccionar un emulador de Android, un simulador de iOS, o tu dispositivo físico conectado.
    
5.  **Iniciar la Depuración:**
    
    Presiona la tecla **`F5`** o ve al menú `Run > Start Debugging`. Esto compilará la aplicación y la lanzará en el dispositivo seleccionado con el modo de "Hot Reload" activado, permitiéndote ver los cambios en el código al instante.

---

## 📦 Cómo Construir el Proyecto (Build)

Si necesitas generar los archivos finales para distribución (por ejemplo, un `.apk` para Android o un paquete para iOS), sigue estas instrucciones.

### Generar APK para Android

Para construir el archivo `.apk` de producción, que puedes instalar manualmente en cualquier dispositivo Android, ejecuta el siguiente comando en la terminal integrada de VS Code:

```bash
flutter build apk
```

Una vez completado, encontrarás el archivo instalador en la siguiente ruta dentro de tu proyecto:

`build/app/outputs/flutter-apk/app-release.apk`


---

## ✨ Estructura del Proyecto

El proyecto sigue una estructura organizada para facilitar su mantenimiento:

```
/ (Raíz del Proyecto)
├── lib/
│   ├── main.dart             # Punto de entrada principal, configuración de tema y rutas.
│   └── screens/
│       ├── documents_screen.dart # Pantalla para la gestión de documentos.
│       └── settings_screen.dart  # Pantalla de configuración.
├── assets/
│   ├── icons/                  # Iconos específicos de la app.
│   └── logo.png                # Logo principal.
└── pubspec.yaml            # Definición de dependencias y assets.
```

---

Este `README` asegura que el proyecto sea **auto-contenido y transferible**. Cualquier desarrollador con las herramientas básicas de Flutter puede, no solo ejecutarlo, sino también construirlo para producción sin necesidad de archivos pre-compilados en el repositorio.