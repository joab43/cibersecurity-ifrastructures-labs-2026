# Recomendaciones de Seguridad

## Objetivo
Este documento recopila recomendaciones de seguridad basadas en la
infraestructura implementada en el laboratorio.

Las recomendaciones no representan un endurecimiento completo de un
entorno de producción, sino mejoras razonables que podrían aplicarse
para reducir riesgos y fortalecer la postura de seguridad.

---

## Segmentación y Red
- Mantener la comunicación entre servidores únicamente a través de la red privada.
- Limitar el acceso externo exclusivamente al servidor LEMP.
- Restringir conexiones al servidor de base de datos por dirección IP.

---

## Gestión de Accesos
- Utilizar autenticación por claves SSH en lugar de contraseñas.
- Deshabilitar el acceso directo al usuario root por SSH.
- Aplicar el principio de privilegios mínimos en usuarios del sistema y de base de datos.

---

## Seguridad del Servidor Web
- Mantener Apache y PHP actualizados.
- Deshabilitar módulos innecesarios.
- Limitar el tamaño de solicitudes y tiempos de espera para evitar abusos.

---

## Seguridad de la Base de Datos
- Separar usuarios administrativos de usuarios de aplicación.
- Restringir el acceso remoto solo a hosts autorizados.
- Evitar el uso de cuentas con privilegios elevados en la aplicación.

---

## Protección de Respaldos
- Almacenar respaldos únicamente en el servidor NAS.
- Restringir el acceso a los directorios de backup.
- Verificar periódicamente la integridad de los respaldos.

---

## Registro y Monitoreo
- Habilitar registros de acceso y error en servicios críticos.
- Revisar logs de manera periódica.
- Centralizar registros en caso de expansión futura del laboratorio.

---

## Gestión de Configuración
- Versionar únicamente archivos de configuración relevantes.
- Evitar subir credenciales o secretos al repositorio.
- Utilizar variables de entorno o archivos ignorados por Git para datos sensibles.

---

## Consideraciones Finales
Estas recomendaciones representan una base de buenas prácticas que
pueden ampliarse o adaptarse conforme el laboratorio evolucione hacia
entornos más complejos o automatizados.
