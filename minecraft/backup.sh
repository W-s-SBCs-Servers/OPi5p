#!/bin/bash

# Définir le fuseau horaire à utiliser
export TZ="America/New_York"

# Dossier des serveurs Minecraft
SERVERS_DIR="/home/servers/minecraft"

# Dossier des backups
BACKUP_DIR="/home/servers/backups"

# Cree le dissier backup si il n existe pas
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Get a list of screen sessions starting with "minecraft"
MINECRAFT_SCREENS=$(screen -ls | grep -oE '\S+\.(minecraft)(\S+)' | awk -F'.' '{print $2}')

# Boucle a travers tous les screen Minecraft
for SCREEN_NAME in $MINECRAFT_SCREENS; do
    # Arrete la session avec la commande "stop"
    screen -S "$SCREEN_NAME" -p 0 -X stuff "stop$(printf \\r)"

    while screen -list | grep -q "$SCREEN_NAME"; do
        echo "En attente de la fermeture de '${SCREEN_NAME}'..."
        sleep 1
    done

    cd $SERVERS_DIR

    # Archiver le dossier du serveur
    DATE=$(date '+%Y-%m-%d_%H-%M-%S')
    tar -czvf "${BACKUP_DIR}/${SCREEN_NAME}_${DATE}.tar.gz" "$SCREEN_NAME"
done

# Relancer les serveurs
nohup ./startup.sh &
