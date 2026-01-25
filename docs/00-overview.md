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
# Visión General del Proyecto

## Contexto
Este proyecto documenta un laboratorio de infraestructura basado en
máquinas virtuales, diseñado para simular un entorno on-premise pequeño
pero realista, similar a los que se encuentran en organizaciones reales.

El laboratorio se construyó con fines educativos y de práctica técnica,
poniendo énfasis en la administración de sistemas, la organización de la
infraestructura y la documentación clara de cada componente.

## Objetivo del Proyecto
El objetivo principal es adquirir experiencia práctica en:

- Diseño de infraestructura básica
- Administración de servidores Linux
- Gestión de bases de datos
- Estrategias de respaldo y recuperación
- Uso de Git y GitHub como herramienta de documentación y control de versiones

Este proyecto sirve como base previa a la adopción de Infraestructura
como Código (IaC), utilizando herramientas como Terraform, Ansible u OPA
en proyectos futuros.

## Alcance
El laboratorio incluye:
- Aprovisionamiento manual de máquinas virtuales
- Configuración de servicios esenciales
- Separación de roles entre servidores
- Documentación técnica estructurada

El laboratorio no pretende:
- Simular un entorno de producción
- Manejar datos reales
- Implementar alta disponibilidad o escalabilidad avanzada

## Público Objetivo
Este proyecto está orientado a:
- Estudiantes de ciberseguridad
- Personas en proceso de aprendizaje de infraestructura
- Práctica personal y portafolio técnico

## Estado del Proyecto
El laboratorio se encuentra en desarrollo activo y puede ser extendido
o modificado conforme se adquieran nuevos conocimientos.
