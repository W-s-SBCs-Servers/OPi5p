## Crontab :

```sh
@reboot sleep 30 && /home/servers/minecraft/startup.sh
0 5 * * * ~/minecraft/backup.sh
*/30 8-22 * * * ~/minecraft/update_datapacks.sh

# Reinitialisation de l'end touts les mois
0 4 1 * * ~/minecraft/reset_dimensions.sh

# Calcul du score d'achievements pour le serveur amplified_public
0 */6 * * 1-5 python3 ~/minecraft/advancements-getter/main.py "~/minecraft/amplified_public/world/advancements/*.json" > ~/minecraft/amplified_public/advancement_scores.txt
30 */6 * * 1-5 python3 ~/minecraft/advancements-getter/scoreboard.py "~/minecraft/amplified_public/advancement_scores.txt" minecraft-amplified_public advancement_scores
0 */3 * * 0,6 python3 ~/minecraft/advancements-getter/main.py "~/minecraft/amplified_public/world/advancements/*.json" > ~/minecraft/amplified_public/advancement_scores.txt
30 */3 * * 0,6 python3 ~/minecraft/advancements-getter/scoreboard.py "~/minecraft/amplified_public/advancement_scores.txt" minecraft-amplified_public advancement_scores
```
