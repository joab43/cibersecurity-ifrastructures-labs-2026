# Servidor de Base de Datos

## Caracteristicas del servidor VM
- Nombre: db_frutas
- SO: Debian 12
- Almacenamiento: 20GB
- RAM: 2048MB (4GB)

## Instalaciones y Configuraciones 

Una vez creada la maquina virtual actualizaremos los paquetes y las dependencias para tener las versiones actuales.

```bash
sudo apt update -y
```

### Paso 1 - Instalación de Herramientas
Ahora instalaremos las herramientas necesarias que utilizara este servidor

```bash
sudo apt install mariadb-server mariadb-client openssh-server chrony rsync openssl -y
```

En esta captura podemos encontrar diferentes herramientas aparte de las necesarias para la base de datos, las cuales nos ayudaran a que el proyecto funcione.

- Mariadb-server: Es el motor de base de datos. 
- Mariadb-client: Es la herramienta de conexión al servidor de base de datos.
- Openssh-server: Proporciona acceso remoto seguro mediante SSH.
- Chrony: Es un servicio NTP moderno. Mantiene sincronizada la hora del servidor con relojes de Internet. Esto es importante porque los respaldos cifrados se nombran con la fecha/hora exacta y para que las tareas cron funcionen correctamente. 
- Rsync: Herramienta para sincronizar y transferir archivos eficientemente.
- Openssl: Herramienta de cifrado y seguridad.

### Paso 2 - Habilitación del servicio de la base de datos
Habilitaremos el servicio de la base de datos para que este activa apenas se inicia el servidor.

```bash
sudo systemctl enable mariadb
```

Iniciamos el servicio 

```bash
sudo systemctl start mariadb
```

Verificamos el estado del servicio el cual debe mostrar `Active`

```bash
sudo systemctl status mariadb
```

### Paso 3 - Configuración SSH y CHRONY
Antes de configurar la base de datos, pasaremos a configurar los demás servicios necesarios para la conexión con los otros servidores y la sincronización del tiempo para los backups de la base de datos.

Empezamos con **ssh**, dentro del fichero que se encuentra en la ruta `/etc/ssh/sshd_config` modificaremos los siguientes parámetros.
<img width="650" height="248" alt="ssh-config" src="https://github.com/user-attachments/assets/d00b47b1-d1ec-4d33-a804-ff6644cab751" />





