# Canon DSLR como Webcam en Linux

Este script permite utilizar una cámara Canon DSLR como webcam en Linux utilizando gphoto2, ffmpeg y v4l2loopback.

La intencion es capturar video con VLC mientras que la camara esta conectada al visor del telescopio por lo que los fotogramas seran pocos pero de maxima resolucion.

## 📌 Requisitos

Antes de ejecutar el script, asegúrate de tener instalados los siguientes paquetes:
```bash
sudo apt update
sudo apt install gphoto2 ffmpeg v4l-utils v4l2loopback-dkms
```

También es recomendable agregar tu usuario al grupo video para evitar problemas de permisos:
```bash
sudo usermod -aG video $USER
```

## 🚀 Uso

Para ejecutar el script, usa el siguiente comando:
```bash
sudo ./start-canon2.sh
```
Esto realizará los siguientes pasos:

 - Descargará y cargará el módulo v4l2loopback.

 - Cerrará cualquier instancia previa de gphoto2.

 - Iniciará la transmisión de la cámara mediante gphoto2 y ffmpeg.

 - Configurará v4l2loopback para exponer la cámara como un dispositivo de video virtual (/dev/video2).

 - Abrirá VLC para visualizar la transmisión en tiempo real.

## 🔧 Solución de problemas

### No detecta la camara (v4l2loopback)

Si el script no funciona, revisa si v4l2loopback está correctamente cargado:
```bash
lsmod | grep v4l2loopback
```

Si no aparece nada, intenta cargarlo manualmente:
```bash
sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2 card_label="Canon DSLR"
```
### No detecta la camara (gphoto2)

Para verificar si gphoto2 detecta la cámara, ejecuta:
```bash
gphoto2 --auto-detect
```

Revisar dispositivos de video disponibles

Ejecuta:
```bash
v4l2-ctl --list-devices
```

Si /dev/video2 no aparece, prueba con /dev/video0 o /dev/video1 en el script.

### VLC no muestra boton grabar

Ve a menu "Ver" > "Controles avanzados"

## 📄 Fuente original del código

Este script está basado en la publicación original de Lucas Coelhof, con algunas modificaciones y mejoras.
[Fuente del código](https://lucascoelhof.github.io/post/2023_08_08_canonM50-linux/)
