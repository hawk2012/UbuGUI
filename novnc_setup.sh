#!/bin/bash
set -e

# Создание директории VNC
mkdir -p ~/.vnc
echo "startfluxbox &" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Запуск Xvfb (виртуальный экран)
Xvfb :1 -screen 0 1280x800x24 &

# Запуск VNC сервера
vncserver :1 -geometry 1280x800 -depth 24 -localhost no

# Запуск noVNC
/opt/noVNC/utils/launch.sh --listen 8080 &
