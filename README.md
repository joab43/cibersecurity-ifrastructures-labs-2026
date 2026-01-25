# Proyecto - Laboratorios de Infraestructura y Ciberseguridad – 2026

## Descripción General
Este repositorio documenta un laboratorio práctico de infraestructura
basado en máquinas virtuales, diseñado para simular un entorno on-premise
realista.

El objetivo principal del proyecto es practicar diseño de infraestructura,
administración de sistemas, planes de respaldo y recuperación, así como
documentación técnica, antes de migrar a enfoques de Infraestructura como
Código (Terraform, Ansible, OPA).

Este repositorio también funciona como bitácora de aprendizaje y portafolio
técnico personal.

---

## Descripción de la Infraestructura
El entorno del laboratorio está compuesto por tres máquinas virtuales:

- **Servidor LEMP**
  - Aloja la capa de aplicación web
  - Linux, Nginx, PHP y cliente MariaDB

- **Servidor de Base de Datos**
  - Servidor dedicado MariaDB
  - Contiene la base de datos principal y bases de prueba

- **Servidor NAS**
  - Almacenamiento centralizado para respaldos
  - Configuración RAID 1
  - Utilizado para validar planes de respaldo y recuperación

---

## Alcance del Proyecto
Incluye:
- Aprovisionamiento manual de máquinas virtuales
- Configuración de servicios
- Gestión de bases de datos
- Pruebas de respaldo y recuperación
- Documentación con enfoque en seguridad

No incluye:
- Proveedores de nube
- Contenedores (Docker / Kubernetes)
- Cargas de trabajo de producción

---

## Estructura del Repositorio

```text
configs/        → Archivos de configuración del sistema y servicios
database/       → Esquemas SQL y datos de prueba
docs/           → Documentación técnica
images/         → Diagramas y capturas de pantalla
```

