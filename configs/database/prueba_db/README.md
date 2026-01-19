# Prueba_DB – Base de Datos de Prueba del Plan de Recuperación

## Propósito
Esta base de datos existe exclusivamente para validar el **plan de respaldo y recuperación**
implementado utilizando el servidor NAS.

Está diseñada intencionalmente de forma simple y aislada de la base de datos ERP principal para permitir
pruebas seguras de creación de respaldos, escenarios de pérdida de datos y procedimientos de recuperación
sin afectar datos similares a producción.

## Alcance de Recuperación
Esta base de datos se utiliza para probar:

- Respaldos automatizados de base de datos
- Restauración manual de respaldos
- Integridad de datos después de la recuperación
- Interacción entre el servidor de base de datos y el servidor NAS

El proceso de recuperación está documentado como parte del plan de recuperación ante desastres.

## Archivos
- `schema.sql`  
  Crea la estructura de la base de datos y tablas utilizada para pruebas de recuperación.

- `seed-data.sql`  
  Inserta datos de prueba controlados utilizados para verificar operaciones exitosas de respaldo y restauración.

## Uso

### Crear esquema

```bash
mysql -u root -p < schema.sql
```

### Insertar datos de prueba
```bash
mysql -u root -p < seed-data.sql
```

