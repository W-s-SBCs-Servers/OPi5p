#!/bin/bash

# Définition du fuseau horaire à utiliser
export TZ="America/New_York"

# Définition du dossier des serveurs Minecraft
SERVERS_DIR="/home/servers/minecraft"

# Définition dossier des backups
BACKUP_DIR="/home/servers/backups"

# Création du dossier de backups si il n'existe pas
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Définition de la liste des "screen" commencant par "minecraft"
MINECRAFT_SCREENS=$(screen -ls | grep -oE '\S+\.(minecraft)(\S+)' | awk -F'.' '{print $2}')

# Boucle a travers tous les screen Minecraft
for SCREEN_NAME in $MINECRAFT_SCREENS; do
    # Arrete la session avec la commande "stop"
    screen -S "$SCREEN_NAME" -p 0 -X stuff "stop$(printf \\r)"

    # Attendre la fermeture du serveur
    while screen -list | grep -q "$SCREEN_NAME"; do
        echo "En attente de la fermeture de '${SCREEN_NAME}'..."
        sleep 1
    done

    cd $SERVERS_DIR

    # Enregistrer le chemin d'accès vers le repertoire du serveur
    SERVER_FOLDER=$(echo $SCREEN_NAME | awk -F'-' '{print $NF}')

    # Supprimer les logs de plus de trois jours
    find $SERVER_FOLDER/logs -type f -name "*.log.gz" ! -newermt "$(date -d '3 days ago')" -delete

    # Archiver le dossier du serveur
    DATE=$(date '+%Y-%m-%d_%H-%M-%S')
    tar -czvf "${BACKUP_DIR}/${SCREEN_NAME}_${DATE}.tar.gz" $SERVER_FOLDER --exclude="wget-log"
done
