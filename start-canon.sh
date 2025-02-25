#!/bin/bash

echo "Retirando el modulo v4l2loopback si esta en memoria"
sudo rmmod v4l2loopback

echo "Cargando v4l2loopback en memoria"
sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2 card_label="Canon 550D" 

echo "Cerrando procesos de gphoto si existen"
sudo pkill -9 gphoto

# Iniciando camara
echo "Iniciando camara"
gphoto2 --stdout --capture-movie | ffmpeg -i - \
  -vf "scale=1920:1080" -c:v rawvideo -pix_fmt yuv420p -threads 0 \
  -r 10 -f v4l2 /dev/video2 &

# Esperar unos segundos para asegurarse de que el stream esté activo
sleep 2

# Ejecutar VLC como usuario normal (no root)
echo "Abriendo VLC para visualizar la cámara"
sudo -u $(logname) vlc v4l2:///dev/video2

