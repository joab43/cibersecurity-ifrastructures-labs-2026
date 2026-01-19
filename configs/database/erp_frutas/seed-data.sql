-- =================================================
-- Datos de prueba para la base de datos ERP_Frutas
-- ATENCION: Este archivo es para uso de LAB / DEMO solo
-- =================================================

USE ERP_Frutas;

-- -----------------------------------------------
-- Tabla: clientes
-- Datos de prueba de clientes
-- -----------------------------------------------
INSERT INTO clientes (nombre, direccion, telefono, email) VALUES
('Juan Perez', 'David', '61234567', 'juan@correo.com'),
('Ana Torres', 'Boquete', '69991234', 'ana@correo.com'),
('Carlos Diaz', 'Bugaba', '60001122', 'carlos@correo.com'),
('Luis Gomez', 'Volcan', '68887777', 'luis@correo.com');

-- -----------------------------------------------
-- Tabla: usuarios
-- Datos de prueba de usuarios
-- Passwords are NOT real
-- -----------------------------------------------
INSERT INTO usuarios (usuario, password, fecha_creacion, ultimo_acceso) VALUES
('admin', 'HASH_DEMO_1', NOW(), NOW()),
('vendedor', 'HASH_DEMO_2', NOW(), NOW()),
('contador', 'HASH_DEMO_3', NOW(), NOW()),
('soporte', 'HASH_DEMO_4', NOW(), NOW());

-- -----------------------------------------------
-- Tabla: producto
-- Datos de prueba de productos
-- -----------------------------------------------
INSERT INTO producto (codigo, nombre, descripcion, categoria_id, precio_venta, stock_actual, stock_minimo) VALUES
('A001', 'Mango', 'Fruta tropical', 1, 2.00, 100, 20),
('A002', 'Piña', 'Fruta dulce', 1, 3.00, 80, 15),
('A003', 'Papaya', 'Fruta naranja', 1, 2.50, 60, 10),
('A004', 'Sandia', 'Fruta grande', 1, 4.00, 40, 8);
