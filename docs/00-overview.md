# Introducción al Laboratorio

El presente proyecto tiene como objetivo la implementación y configuración de un entorno de 
servidores bajo el sistema operativo Debian 12, orientado a la gestión, respaldo y seguridad de 
bases datos enuna infraestructura simulada de producción. 

Durante su desarrollo se configuraron tres servidores principales: un servidor de base de datos (DB
FRUTAS), un servidor web (WEB-FRUTAS) y un servidor de respaldo (NAS-FRUTAS). Cada uno 
cumple un rol específico dentro del ecosistema, garantizando la disponibilidad, integridad y 
confidencialidad de la información.

El proyecto abarca procesos fundamentales de administración de sistemas como la instalación de 
servicios de MariaDB, Apache, NTP, la implementación de un esquema de respaldo automatizado, 
cifrado AES-256-CBC, y la transferencia segura mediante SSH sin uso de contraseñas. Además, se 
integró un arreglo RAID-1 por software en el servidor NAS para garantizar la redundancia de los 
datos y una mayor tolerancia a fallos. 

Este entorno busca emular las prácticas de seguridad, mantenimiento y automatización presentes 
en un entorno empresarial real, reforzando los conocimientos en administración de servidores 
Linux, gestión de servicios de red y buenas prácticas en ciberseguridad.