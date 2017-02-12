FROM debian:jessie

# Modified from Dockerfile created by Ryan Sheehan
# <https://github.com/ryansheehan/terraria/blob/master/Dockerfile>
# See LICENSE file.
MAINTAINER Brett Vickers <https://github.com/beevik>

# Add mono repository
# Update and install mono and a zip utility
# fix for favorites.json error
RUN apt-get update && apt-get install -y zip mono-complete && \
    apt-get clean && \
    favorites_path="/root/My Games/Terraria" && mkdir -p "$favorites_path" && echo "{}" > "$favorites_path/favorites.json"

# Download and install TShock
ENV TSHOCK_VERSION=4.3.22 \
    TSHOCK_FILE_POSTFIX=""

ADD https://github.com/NyxStudios/TShock/releases/download/v$TSHOCK_VERSION/tshock_$TSHOCK_VERSION.zip /
RUN unzip tshock_$TSHOCK_VERSION.zip -d /tshock && \
    rm tshock_$TSHOCK_VERSION.zip && \
    chmod 777 /tshock/TerrariaServer.exe

# Allow for external data
VOLUME ["/world", "/tshock/ServerPlugins"]

# Set working directory to server
WORKDIR /tshock

# run the server
ENTRYPOINT ["mono", "--server", "--gc=sgen", "-O=all", "TerrariaServer.exe", "-configpath", "/world", "-worldpath", "/world", "-logpath", "/world"]
