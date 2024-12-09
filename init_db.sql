-- Crear la base de datos 'pets' si no existe
CREATE DATABASE IF NOT EXISTS pets;

-- Seleccionar la base de datos 'pets'
USE pets;

-- Crear la tabla 'usuario' si no existe
CREATE TABLE IF NOT EXISTS usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- Insertar un usuario de prueba en 'usuario'
INSERT INTO usuario (username, password) VALUES ('perl_user', 'perl_user');

-- Crear la tabla 'pets' si no existe
CREATE TABLE IF NOT EXISTS pets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    owner VARCHAR(25) NOT NULL,
    species VARCHAR(25) NOT NULL,
    sex ENUM('Male', 'Female') NOT NULL,
    birth DATE NOT NULL,
    death DATE
);

-- Insertar datos iniciales en 'pets'
INSERT INTO pets (name, owner, species, sex, birth, death) VALUES
    ('Fluffy', 'Harold', 'Cat', 'Female', '2010-03-01', NULL),
    ('Buddy', 'Susan', 'Dog', 'Male', '2015-05-05', NULL),
    ('Misty', 'John', 'Dog', 'Female', '2012-07-07', NULL),
    ('Charlie', 'Anna', 'Rabbit', 'Male', '2018-01-15', NULL),
    ('Daisy', 'Laura', 'Bird', 'Female', '2016-09-09', '2021-06-01');

-- Crear el usuario MySQL 'perl_user' si no existe y asignar privilegios
CREATE USER IF NOT EXISTS 'perl_user'@'%' IDENTIFIED BY 'perl_user';

-- Asignar todos los privilegios al usuario 'perl_user' en la base de datos 'pets'
GRANT ALL PRIVILEGES ON pets.* TO 'perl_user'@'%';

-- Aplicar los cambios de permisos
FLUSH PRIVILEGES;

