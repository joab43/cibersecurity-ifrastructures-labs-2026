# Configuración de las tareas con crontab
Ahora vamos a programar las tareas de respaldo diario con crontab.
```
sudo crontab -e 
```

agregaremos la siguiente linea al final del archivo:

```bash
# m h  dom mon down   command
1 0 * * * /var/opt/Respaldo/backup.sh >> /var/opt/Respaldo/cron_run.log 2>&1 
```

Verificamos para comprobar que la tarea se haya añadido:

```bash
crontab -l
```

Debería aparecer la linea que hemos añadido al final del archivo.



