## Crontab :

```sh
@reboot sleep 30 && /home/servers/minecraft/startup.sh
0 5 * * * /home/servers/minecraft/backup.sh
0 8-22 * * * /home/servers/minecraft/update_datapacks.sh

# Reinitialisation de l'end touts les mois
0 4 1 * * ~/minecraft/reset_dimensions.sh

# Calcul du score d'achievements pour le serveur amplified_public
0 12 * * 1-5 python3 /home/servers/minecraft/advancements-getter/main.py "/home/servers/minecraft/amplified_public/world/advancements/*.json" > /home/servers/minecraft/amplified_public/advancement_scores.txt
30 12 * * 1-5 python3 /home/servers/minecraft/advancements-getter/scoreboard.py "/home/servers/minecraft/amplified_public/advancement_scores.txt" minecraft-amplified_public advancement_scores
0 */12 * * 0,6 python3 /home/servers/minecraft/advancements-getter/main.py "/home/servers/minecraft/amplified_public/world/advancements/*.json" > /home/servers/minecraft/amplified_public/advancement_scores.txt
30 */12 * * 0,6 python3 /home/servers/minecraft/advancements-getter/scoreboard.py "/home/servers/minecraft/amplified_public/advancement_scores.txt" minecraft-amplified_public advancement_scores
```
