# Servidor de Base de Datos

## Características del servidor VM
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
Ahora instalaremos las herramientas necesarias que utilizara este servidor.

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

Iniciamos el servicio.

```bash
sudo systemctl start mariadb
```

Verificamos el estado del servicio el cual debe mostrar `Active (Running)`.

```bash
sudo systemctl status mariadb
```

### Paso 3 - Configuración SSH y CHRONY
Antes de configurar la base de datos, pasaremos a configurar los demás servicios necesarios para la conexión con los otros servidores y la sincronización del tiempo para los backups de la base de datos.

#### SSH
Empezamos con **ssh**, dentro del fichero que se encuentra en la ruta `/etc/ssh/sshd_config` modificaremos los siguientes parámetros.
<img width="650" height="248" alt="ssh-config" src="https://github.com/user-attachments/assets/d00b47b1-d1ec-4d33-a804-ff6644cab751" />



##### Reinicio del servicio SSH

Primero habilitaremos el servicio para que este activo a la hora de iniciar el servidor.
```bash
sudo systemctl enable ssh
```

Pasaremos a reiniciar el servicio para aplicar los cambios que hemos realizado.
```bash
sudo systemctl restart ssh
```

Por ultimo verificaremos que el servicio este corriendo correctamente, el estado debe mostrar `Active (Running)`.
```bash
sudo systemctl status ssh
```

#### CHRONY
Con esta herramienta solo verificaremos que este corriendo como servicio y su correcto funcionamiento.

Habilitamos el servicio para que inicie junto con el servidor.
```bash
sudo systemctl enable chrony
```

Iniciamos el servicio.
```bash
sudo systemctl start chrony
```

Verificamos el estado del servicio debe mostrar `Active (Running)`.
```bash
sudo systemctl status chrony
```

Por ultimo verificaremos el funcionamiento de la herramienta.
```bash
chronyc tracking
```

Deberá mostrar algo así

![[chrony-exit.png]]

### Paso 3 - Configuración de MariaDB
Ahora configuremos la base de datos, para esto debemos ejecutar el cliente y proceder a ingresar los siguientes parámetros.
```bash
mysql_secure_installation
```
- **Enter current password for root:** se introduce la contraseña del usuario root del servidor 
- **Set root password?:** `y` - para aplicar la contraseña del usuario, en este caso va a ser `1234`. 
- **Remove anonymous users? [Y/n]:** `y` - elimina usuarios anónimos por seguridad. 
- **Disallow root login remotely? [Y/n]:** y - impide login directo de root desde la red; mejor usar cuentas limitadas. 
- **Remove test database and access to it[Y/n]:** `y` - no dejar bases de datos de prueba en producción. 
- **Reload privilege tables now? [Y/n]:** `y` - aplica cambios inmediatamente.

Luego iniciaremos sesión en el cliente de la base de datos.
```bash
sudo mysql -u root -p1234
```

Dentro crearemos un usuario llamado erp_user el cual usaremos para hacer las conexiones con la base de datos.

```sql
CREATE USER 'erp_user'@'%' IDENTIFIED BY '1234';
```

Le daremos privilegios para manejar las base de datos creadas

```sql
GRANT ALL PRIVILEGES ON ERP_Frutas.* TO 'erp_user'@'%';
GRANT ALL PRIVILEGES ON Prueba_DB.* TO 'erp_user'@'%';
```

> :exclamation: **Aviso**: Por motivos de prueba se le esta dando máximos privilegios a el usuario **erp_user** lo cual en un entorno de producción es una mala practica de seguridad, se recomienda usar el principio de mínimo privilegio en entornos de producción.

##### BASE DE DATOS ERP_FRUTAS - TABLAS
Crearemos la base de datos junto a las tablas, las cuales son las siguientes:

###### Usuarios
| Column name    | Type         | Description                          |
| -------------- | ------------ | ------------------------------------ |
| id_usuario     | INT          | Identificador para el usuario.       |
| usuario        | VARCHAR(50)  | Nombre de usuario.                   |
| password       | VARCHAR(255) | Contraseña del usuario.              |
| fecha_creacion | DATETIME     | Fecha de creación del usuario.       |
| ultimo_acceso  | DATETIME     | Fecha del ultimo acceso del usuario. |
###### Clientes
| Column name | Type         | Description                     |
| ----------- | ------------ | ------------------------------- |
| id_clientes | INT          | Identificador para los clientes |
| nombre      | VARCHAR(100) | Nombre de los clientes          |
| direccion   | VARCHAR(100) | Dirección de los clientes       |
| telefono    | VARCHAR(20)  | telefono de los clientes        |
| email       | VARCHAR(100) | Correo de los clientes          |
###### Producto
| Column name  | Type            | Description                      |
| ------------ | --------------- | -------------------------------- |
| id_producto  | INT             | Identificador de los productos   |
| codigo       | VARCHAR(50)     | Código de los productos          |
| nombre       | VARCHAR(100)    | Nombre de los productos          |
| descripcion  | TEXT            | Descripcion de los productos     |
| categoria_id | INT             | Categoria de los productos       |
| precio_venta | DECIMAL(10, 20) | Precio de venta de los productos |
| stock_actual | INT             | Stock actual del producto        |
| stock_minimo | INT             | Stock mínimo del procuctos       |
##### BASE DE DATOS PRUEBA_DB - TABLAS
Por ultimo crearemos una ultima base de datos para probar el funcionamiento de la función de creación y almacenamiento del respaldo en el servidor NAS.

| Column Name | Data Type    | Constraints                 | Description                                         |
| ----------- | ------------ | --------------------------- | --------------------------------------------------- |
| `id`        | INT          | PRIMARY KEY, AUTO_INCREMENT | Identificador                                       |
| `nombre`    | VARCHAR(100) | NOT NULL                    | Nombre de prueba                                    |
| `valor`     | INT          | NOT NULL                    | Valor numérico usado para la prueba de recuperacion |
