# Arquitectura de la Infraestructura

## Descripción General
La infraestructura del laboratorio está compuesta por tres máquinas
virtuales independientes, cada una con un rol claramente definido.

El diseño busca aplicar el principio de separación de responsabilidades,
permitiendo aislar servicios y facilitar la administración, el monitoreo
y las pruebas de recuperación.

## Componentes del Entorno

### Servidor LEMP
- Proporciona la capa de aplicación web
- Ejecuta servicios web y lógica de la aplicación
- Se comunica únicamente con el servidor de base de datos

### Servidor de Base de Datos
- Servidor dedicado MariaDB
- Aloja la base de datos principal del sistema
- Contiene una base de datos de prueba utilizada para validar planes de recuperación
- No expone servicios directamente a usuarios finales

### Servidor NAS
- Proporciona almacenamiento centralizado para respaldos
- Configurado con RAID 1 para redundancia
- Almacena copias de seguridad del servidor de base de datos
- Se utiliza exclusivamente para pruebas de backup y restore

## Diseño de Red
Las máquinas virtuales se comunican a través de una red privada, lo que
permite:

- Aislamiento del entorno del sistema anfitrión
- Comunicación controlada entre servidores
- Simulación de un entorno on-premise real

El acceso externo se limita al servidor LEMP, mientras que los demás
servidores solo aceptan conexiones desde direcciones internas autorizadas.

## Flujo de Comunicación
1. El usuario accede al servidor LEMP
2. El servidor LEMP consulta datos al servidor de base de datos
3. El servidor de base de datos realiza respaldos periódicos hacia el NAS
4. El NAS almacena los respaldos para recuperación ante fallos

## Diagramas
Los diagramas de arquitectura lógica y de red se encuentran en el
directorio `/images` y complementan la descripción de este documento.
