#!/bin/bash
set -e

# Создание директории VNC
mkdir -p ~/.vnc
echo "fluxbox &" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Установка пароля VNC (опционально, можно закомментировать если не нужен)
if [ -n "$VNC_PASS" ]; then
    mkdir -p ~/.vnc
    echo "$VNC_PASS" | vncpasswd -f > ~/.vnc/passwd
    chmod 600 ~/.vnc/passwd
fi

# Запуск Xvfb (виртуальный экран)
Xvfb :1 -screen 0 1280x800x24 -ac +extension GLX +render -noreset &

# Ждем немного, чтобы Xvfb запустился
sleep 2

# Запуск VNC сервера
vncserver :1 -geometry 1280x800 -depth 24 -localhost no

# Запуск noVNC
/opt/noVNC/utils/launch.sh --listen 8080 --vnc localhost:5901 &
