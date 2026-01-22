# Configuración del Sistema de Respaldo
Ahora configuraremos el sistema de respaldo, para ello iremos al servidor de la base de datos y crearemos una carpeta llamada Respaldo en el directorio `/var/opt/` y le daremos permisos de lectura, escritura y ejecución para el usuario propietario y para los demás solo permisos de lectura y ejecución.

## Paso 1 - Creación del directorio

```bash
sudo mkdir -p /var/opt/Respaldo
sudo chmod 755 /var/opt/Respaldo 
```

## Paso 2 - Creación de archivo con credenciales
Ahora pasaremos a crear la autenticación segura para MySQL, en lugar de escribir usuario y contraseña dentro del script, guardamos las credenciales en un archivo protegido.

```bash
sudo nano /root/.my.cfn
sudo tee /root/.my.cfn > /dev/null << 'EOF'
>[Client]
>user=root
>password=123
>EOF
```

Este archivo lo ocultaremos en el directorio `/root/` y le daremos permisos 600 lo que significa que el propietario tiene permisos de escritura y lectura, mientras que todos los demás usuarios no tienen ningún permiso.
```bash
sudo chmod 600 /root/.my.cfn
```

## Paso 3 - Configuración de SSH hacia el servidor NAS
Pasaremos a Configurar autenticación SSH sin contraseña hacia el NAS, esto garantiza el envío seguro al servidor de respaldo sin usar usuario/contraseña (solo clave pública).

En el servidor de la base de datos ejecutaremos el siguiente comando:

```bash
ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa_backup -N ""
```

Copiaremos la clave pública al servidor NAS (nas-frutas).

```bash
sudo ssh-copy-id -i /root/.ssh/id_rsa_backup.pub
```

Una vez copiada la clave pública exitosamente comprobaremos la conexión de la siguiente forma, en el servidor de la base de datos ejecutaremos el siguiente comando:

```bash
ssh -i /root/.ssh/id_rsa_backup nas_user@<ip-del-servidor-nas> "echo Conexión exitosa"
```

# Paso 4 - Creación de archivo passphrase
Crearemos un archivo con la passphrase de cifrado, el script usará este archivo para cifrar los .sql con AES-256-CBC sin incluir la clave en el código.

```bash
echo "1234" | tee /root/.backup_pass > /dev/null
```

# Paso 5 - Creación de script de backup
Ahora pasaremos a crear el script de respaldo automático y asicaremos los permisos necesarios.

```bash
sudo nano /var/opt/Respaldo/backup.sh
sudo chmod 700 /vas/opt/Respaldo/backup.sh
sudo chown root:root /var/opt/Respaldo/backup.sh
```

Copiamos el siguiente código del archivo `backup.sh` que se encuentra en el repositorio y lo pegan en el archivo que ustedes hayan creado con extensión `.sh`. 
