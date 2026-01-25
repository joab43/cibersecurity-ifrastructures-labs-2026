## Características del servidor VM
- Nombre: nas_frutas
- SO: Debian 12
- Almacenamiento: 
	- nas-frutas_1.vdi - 25GB
	- nas-frutas_2.vdi - 12GB
- RAM: 2048MB (4GB)

## Configuración del Servidor NAS 
Antes de empezar a configurar el servidor NAS crearemos y le añadiremos 2 disco duros virtuales en el hipervisor utilizado.

![[Pasted image 20260120170410.png]]

Podemos ver que el disco nas-frutas_1.vdi tiene un tamaño de 25.00GB y el nas-frutas_2.vdi tiene un tamaño de 12.00GB.

## Paso 1 - Actualización de paquetes
Una vez ya con los dos discos duros virtuales conectados iniciaremos la máquina virtual y empezaremos con la configuración del servidor con una actualización de los paquetes.

```bash
sudo apt update -y
```

## Paso 2 - Instalación de herramientas necesarias
Pasaremos a instalar las siguientes herramientas:

`mdadm`: herramienta para crear y gestionar RAID por software. 
`rsync`: recibe archivos cifrados desde el servidor DB-SRV (sin credenciales visibles). 
`chrony`: mantiene la hora sincronizada (para coincidir con la del DB-SRV).

## Paso 3 - Particionado de discos

Empezamos ejecutando el comando fdisk –l para ver lo siguiente:

```bash
sudo fdisk -l
```

![[Pasted image 20260120174520.png]]

Haremos el particionado de la siguiente forma: 

**Disco #1 - /dv/sdb 25GB:** 
- Partición raíz – 14GB 
- Partición de respaldo – 10GB 
- Partición swap - 1GB

Ejecutaremos el comando:
```bash
sudo fdisk /dev/sdb
```

Aquí ejecutaremos los siguientes parámetros: 
- **n:** para crear una nueva partición.
- **p:** indica que es una partición primaria.
- **1,2,3:** un número a la vez para indicar el número de partición.
- **Enter:** para usar el inicio por defecto.
- **+14G, +10G, +1G:** para indicar el tamaño de la partición.

Haremos el mismo proceso para el disco número dos con la diferencia que los 10GB completos van a ser para el respaldo.
- **n:** para crear una nueva partición.
- **p:** indica que es una partición primaria.
- **1:** un número a la vez para indicar el número de partición.
- **Enter:** para usar el inicio por defecto.
- **+10G:** para indicar el tamaño de la partición.

Ahora verificaremos las particiones creadas y veremos que efectivamente las particiones en el disco sed se ha creado como sdb1, sdb2, sdb3.
![[Pasted image 20260120180023.png]]

## Paso 4 - Creación del RAID 1
Ahora para crear el arreglo tipo RAID-1 ejecutaremos el siguiente comando:

```bash
mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb2 /dev/sdc1
```

Para verificar que el arreglo se haya creado buscaremos el archivo mdstat en el directorio /proc/

```bash
cat /proc/mdstat
```

![[Pasted image 20260120180518.png]]

Ahora formatearemos el RAID en formato ext4 para poder montarlo como unidad.

```bash
mkfs.ext4 /dev/md0
```

Ahora creamos una carpeta llamada `RespaldoHistorico` en la dirección `/var/opt/` para posteriormente montar la unidad del `RAID md0` en esta carpeta previamente llamada `RespaldoHistorico`.

```bash
sudo mkdir /var/opt/RespaldoHistorico -p
sudo mount /dev/md0 /var/opt/RespaldoHistorico
```

Verificamos que se ha montado correctamente la unidad

```bash
sudo df -h | grep md0
```

También modificaremos el archivo de configuración `fstab` para que la unidad se monte automáticamente al iniciar el servidor, para esto usaremos el comando `echo`.

```bash
echo '/dev/md0 /var/otp/RespaldoHistorico etx4 defaults 0 0' | sudo tee -a /etc/fstab
```

Ahora guardaremos la configuración del RAID

```bash
mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
```

## Paso 5 - Configuración del swap de memoria
Ahora pasaremos a configurar la memoria swap, para esto debemos formatearla para luego activarla.

```bash
mkswap /dev/sdb3
```

![[Pasted image 20260120182057.png]]

```bash
swapon --show
```
Podemos observar que el swap está funcionando correctamente, por ultimo la agregaremos al archivo fstab, para esto editaremos el archivo con nano y agregaremos la siguiente línea.

```bash
/dev/sdb3        none     swap     0      0
```

Una vez hecho esto reiniciaremos el servidor para posterior mente comprobar el correcto funcionamiento de todas las configuraciones hechas anteriormente.

```bash
sudo cat /proc/mdstat
```

![[Pasted image 20260120182419.png]]

