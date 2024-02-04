#!/bin/bash
# Script d'initialisation des serveurs

function start_server {
    local NAME="$1"
    local MEMORY="$2"
    local DIRECTORY="/home/servers/minecraft/$NAME"

    cd "$DIRECTORY" || exit 1

    screen -dmS "minecraft-$NAME" java -Xms512M -Xmx${MEMORY}G -jar server.jar nogui

    if [ $? -eq 0 ]; then
        echo "Serveur $NAME démarré avec succès."
    else
        echo "Échec du démarrage du serveur $NAME."
    fi
}

# Life enjoyers
# start_server "tests" 2

# Serveur public
start_server "public" 6
