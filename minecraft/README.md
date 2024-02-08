## Crontab :

```sh
@reboot sleep 30 && /home/servers/minecraft/startup.sh
0 5 * * * /home/servers/minecraft/backup.sh
*/30 8-22 * * * /home/servers/minecraft/update_datapacks.sh

# Reinitialisation de l'end touts les mois
0 4 1 * * /home/servers/minecraft/reset_dimensions.sh

# Calcul du score d'advancements pour le serveur public
0 */3 8-23 * * python3 minecraft/advancements-getter/main.py "/home/servers/minecraft/public/world/advancements/*.json" > /home/servers/minecraft/public/advancement_scores.txt
30 */3 8-23 * * python3 minecraft/advancements-getter/scoreboard.py "/home/servers/minecraft/public/advancement_scores.txt" minecraft-public advancement_scores
```
