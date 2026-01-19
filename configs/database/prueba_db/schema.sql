-- ============================================
-- Database: Prueba_DB
-- Ambiente: TEST / LAB
-- Propósito: SQL testing and validation
-- ===========================================

-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS Prueba_DB;
USE Prueba_DB;

CREATE TABLE IF NOT EXISTS demo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    valor INT NOT NULL
);
