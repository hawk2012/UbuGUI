FROM ubuntu:25.04

# Установка базовых пакетов
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        wget \
        gpg \
        sudo \
        locales \
        net-tools \
        procps \
        xz-utils \
        xvfb \
        fluxbox \
        tightvncserver \
        dbus-x11 \
        git \
        python3 \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Добавление i386 архитектуры
RUN dpkg --add-architecture i386

# Ключи и репозитории WineHQ
RUN mkdir -pm755 /etc/apt/keyrings && \
    wget -qO- https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key && \
    wget -qNP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/plucky/winehq-plucky.sources 

# Обновление пакетов
RUN apt-get update

# Установка Wine Staging
RUN apt-get install -y --install-recommends winehq-staging

# Установка winetricks
RUN apt-get install -y winetricks winbind

# Локали
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Установка noVNC
ENV NOVNC_HOME /opt/noVNC
RUN cd /tmp && \
    git clone https://github.com/novnc/noVNC.git  $NOVNC_HOME && \
    $NOVNC_HOME/utils/websockify/run --help >/dev/null 2>&1 || true

# Установка websockify
RUN pip3 install websockify

# Копируем скрипты
COPY entrypoint.sh /entrypoint.sh
COPY novnc_setup.sh /novnc_setup.sh
RUN chmod +x /entrypoint.sh /novnc_setup.sh

# ENV vars
ENV WINEARCH=win32
ENV WINEPREFIX=/home/user/.wine
ENV DISPLAY=:1
ENV HOME=/home/user

EXPOSE 5901 8080

ENTRYPOINT ["/entrypoint.sh"]
