#!/bin/bash
set -e

USERNAME=${VNC_USER:-user}
PASSWORD=${VNC_PASS:-1}

# Создаём пользователя, если его нет
if ! id "$USERNAME" >/dev/null 2>&1; then
  useradd -m -s /bin/bash "$USERNAME" && \
  echo "$USERNAME:$PASSWORD" | chpasswd && \
  adduser "$USERNAME" sudo
fi

export USER=$USERNAME
export HOME=/home/$USER
cd $HOME

# Запуск D-Bus
sudo service dbus start

# Запуск VNC/X11
/novnc_setup.sh

# Настройка Wine
export WINEARCH=win32
export WINEPREFIX=$HOME/.wine

rm -rf "$WINEPREFIX"
winecfg
wineboot -u
winetricks corefonts tahoma lucida vb6run dotnet48 msxml6 winhttp mfc42 jet40 native_oleaut32

# Оставляем контейнер активным
echo "=> Контейнер запущен. Подключайтесь через http://localhost:8080/vnc.html"
tail -f /dev/null
