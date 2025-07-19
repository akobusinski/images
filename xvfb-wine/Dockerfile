FROM ubuntu:22.04

WORKDIR /tmp

# Install wget
RUN apt update
RUN apt install -y wget

# 32 bit architecture
RUN dpkg --add-architecture i386

# Install Wine
RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
RUN apt update
RUN apt install -y winehq-stable
RUN apt install -y winbind

# Turn off Fixme warnings
ENV WINEDEBUG "fixme-all"

# Install Xvfb
RUN apt install -y xvfb

# Install Winetricks
RUN apt install -y cabextract
RUN wget -O /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x /usr/local/bin/winetricks

# Setup a Wine prefix
RUN wineboot -i
ENV WINEPREFIX "/wine"
ENV WINEARCH "win64"
RUN winetricks -q win7
RUN wineboot -u

# Start Xvfb
ENV DISPLAY ":1"
RUN Xvfb ${DISPLAY} &

# Install .NET Framework 4.7.2
RUN winetricks -q dotnet472
RUN winetricks -q corefonts
RUN winetricks sound=disabled
