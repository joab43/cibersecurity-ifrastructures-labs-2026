-- ============================================
-- Database: ERP_Frutas
-- DBMS: MariaDB
-- Purpose: Database schema creation
-- ============================================

CREATE DATABASE IF NOT EXISTS ERP_Frutas;
USE ERP_Frutas;

-- --------------------------------------------
-- Tabla: usuarios
-- Almacena las cuentas de usuario de la aplicación
-- --------------------------------------------
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso DATETIME NULL
);

-- --------------------------------------------
-- Tabla: clientes
-- Almacena los clientes de la aplicación
-- --------------------------------------------
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- --------------------------------------------
-- Tabla: productos 
-- Almacena los productos de la aplicación
-- --------------------------------------------
CREATE TABLE IF NOT EXISTS productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    categoria_id INT NOT NULL,
    precio_venta DECIMAL(10, 2) NOT NULL,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL
);
