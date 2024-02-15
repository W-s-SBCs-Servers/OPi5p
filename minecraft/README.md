## Crontab :

```sh
@reboot sleep 30 && /home/servers/minecraft/startup.sh
0 5 * * * /home/servers/minecraft/backup.sh
*/30 8-22 * * * /home/servers/minecraft/update_datapacks.sh

# Reinitialisation de l'end touts les mois
0 4 1 * * /home/servers/minecraft/reset_dimensions.sh

# Calcul du score d'advancements pour le serveur public
0 */6 6-22 * 1-5 python3 minecraft/advancements-getter/main.py "/home/servers/minecraft/amplified_public/world/advancements/*.json" > /home/servers/minecraft/amplified_public/advancement_scores.txt
30 */6 6-22 * 1-5 python3 minecraft/advancements-getter/scoreboard.py "/home/servers/minecraft/amplified_public/advancement_scores.txt" minecraft-amplified_public advancement_scores
0 */3 * * 0,6 python3 minecraft/advancements-getter/main.py "/home/servers/minecraft/amplified_public/world/advancements/*.json" > /home/servers/minecraft/amplified_public/advancement_scores.txt
30 */3 * * 0,6 python3 minecraft/advancements-getter/scoreboard.py "/home/servers/minecraft/amplified_public/advancement_scores.txt" minecraft-amplified_public advancement_scores
```
