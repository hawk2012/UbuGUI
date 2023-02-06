FROM ubuntu:kinetic
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install net-tools tightvncserver -y
RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/kinetic/winehq-kinetic.sources
RUN apt-get update
RUN apt-get install wine winetricks winbind xorg-dev libx11-dev -y
CMD rm -Rf ~/.wine && WINEARCH=win32 WINEPREFIX=/home/$(whoami)/.wine winecfg && wineboot -u && winetricks winhttp msxml3 msxml4 dotnet45 corefonts lucida tahoma vb6run mdac28 mfc42 jet40 native_oleaut32 && winetricks --force dotnet472;