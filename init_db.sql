-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS pets;

-- Crear el usuario y asignar todos los privilegios
CREATE USER 'perl_user'@'%' IDENTIFIED BY 'perl_user';
GRANT ALL PRIVILEGES ON pets.* TO 'perl_user'@'%';
FLUSH PRIVILEGES;

-- Seleccionar la base de datos
USE pets;

-- Crear la tabla 'pets'
CREATE TABLE IF NOT EXISTS pets (
    name VARCHAR(25),
    owner VARCHAR(25),
    species VARCHAR(25),
    sex VARCHAR(10),
    birth VARCHAR(45),
    death VARCHAR(45)
);
