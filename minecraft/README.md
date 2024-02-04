## Crontab :

```sh
@reboot sleep 30 && /home/servers/minecraft/startup.sh
0 5 * * * /home/servers/minecraft/backup.sh
*/30 8-22 * * * /home/servers/minecraft/update_datapacks.sh

# Reinitialisation de l'end toutes les deux semaines
0 4 */16 * * /home/servers/minecraft/reset_dimensions.sh
```
