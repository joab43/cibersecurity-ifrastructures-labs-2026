# Base de Datos ERP_Frutas

## Propósito
Este directorio contiene scripts SQL utilizados para inicializar y poblar
la base de datos ERP_Frutas utilizada por el servidor de aplicaciones.

La base de datos está diseñada para almacenar datos de usuarios, clientes y productos.

## Archivos
- `schema.sql`: Crea el esquema de la base de datos (tablas y restricciones)
- `seed-data.sql`: Inserta datos de demostración solo para fines de prueba

## Uso

### Crear esquema

```bash
mysql -u root -p < schema.sql
```
### Insertar Datos
```bash
mysql -u root -p < seed-data.sql
```
