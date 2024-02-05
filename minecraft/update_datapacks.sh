#!/bin/bash

# Dossier des serveurs Minecraft
SERVERS_DIR="/home/servers/minecraft"

# Get a list of screen sessions starting with "minecraft"
MINECRAFT_SCREENS=$(screen -ls | grep -oE '\S+\.(\S+)' | awk -F'.' '{print $2}')

# Boucle à travers tous les screen Minecraft
for SCREEN_NAME in $MINECRAFT_SCREENS; do
    # Dossier des datapacks du serveur
    DATAPACKS_DIR="$SERVERS_DIR/$SCREEN_NAME/world/datapacks"

    # Aller dans le dossier des datapacks du serveur
    cd $DATAPACKS_DIR

    # Boucle à travers tous les sous-dossiers dans "datapacks"
    for DATAPACK_DIR in */; do
        # Aller dans le sous-dossier du datapack
        cd "$DATAPACK_DIR"

        # Récupérer les modifications du dépôt distant
        git fetch

        # Vérifier s'il y a des modifications locales
        LOCAL_REV=$(git rev-parse HEAD)
        REMOTE_REV=$(git rev-parse origin/main)

        if [ "$LOCAL_REV" != "$REMOTE_REV" ]; then
            echo "Des changements détectés pour $SCREEN_NAME/$DATAPACK_DIR. Mise à jour en cours..."

            # Mettre à jour la branche "main" depuis le dépôt GitHub
            git pull origin main

            # Vérifier si la mise à jour a réussi
            if [ $? -eq 0 ]; then
                echo "Mise à jour réussie pour $SCREEN_NAME/$DATAPACK_DIR. Rechargement en cours..."

                # Recharge le datapack "reload"
                screen -S "$SCREEN_NAME" -p 0 -X stuff "reload$(printf \\r)"
            else
                echo "Échec de la mise à jour pour $SCREEN_NAME/$DATAPACK_DIR."
            fi
        else
            echo "Aucun changement détecté pour $SCREEN_NAME/$DATAPACK_DIR. Pas de mise à jour nécessaire."
        fi

        # Revenir au dossier des datapacks
        cd $DATAPACKS_DIR
    done
done
