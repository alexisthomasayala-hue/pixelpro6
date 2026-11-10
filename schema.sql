-- =====================================================
-- schema.sql - PixelPro🎮
-- Ejecutar en phpMyAdmin / Laragon / XAMPP (MySQL 5.7+ / MariaDB)
-- =====================================================

CREATE DATABASE IF NOT EXISTS pixelpro_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pixelpro_db;

-- -----------------------------------------------------
-- Tablas maestras / secundarias
-- -----------------------------------------------------
CREATE TABLE roles (
  id_rol INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE generos_usuario (
  id_genero INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE categorias_juego (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE tipos_publicacion (
  id_tipo INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE idiomas (
  id_idioma INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Usuarios (autenticación + datos personales + rol)
-- Campos tomados de formulario.php
-- -----------------------------------------------------
CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre_completo VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,            -- hash generado con password_hash() en PHP
  fecha_nacimiento DATE NULL,
  id_genero INT NULL,
  acepto_terminos TINYINT(1) NOT NULL DEFAULT 0,
  id_rol INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
  FOREIGN KEY (id_genero) REFERENCES generos_usuario(id_genero)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Juegos
-- -----------------------------------------------------
CREATE TABLE juegos (
  id_juego INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  descripcion TEXT NULL,
  id_categoria INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_categoria) REFERENCES categorias_juego(id_categoria)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Tabla principal de negocio: publicaciones (blog y noticias)
-- -----------------------------------------------------
CREATE TABLE publicaciones (
  id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  contenido TEXT NOT NULL,
  imagen VARCHAR(255) NULL,
  id_autor INT NOT NULL,
  id_tipo INT NOT NULL,
  id_juego INT NULL,                         -- una noticia puede no estar ligada a un juego propio
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_autor) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (id_tipo) REFERENCES tipos_publicacion(id_tipo),
  FOREIGN KEY (id_juego) REFERENCES juegos(id_juego) ON DELETE SET NULL
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Comentarios de la comunidad
-- -----------------------------------------------------
CREATE TABLE comentarios (
  id_comentario INT AUTO_INCREMENT PRIMARY KEY,
  id_publicacion INT NOT NULL,
  id_usuario INT NOT NULL,
  texto TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion) ON DELETE CASCADE,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Formulario "Deseas unirte" + relación N:M con idiomas
-- -----------------------------------------------------
CREATE TABLE solicitudes_union (
  id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  descripcion_personal TEXT NOT NULL,
  experiencia TEXT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE solicitud_idioma (
  id_solicitud_idioma INT AUTO_INCREMENT PRIMARY KEY,
  id_solicitud INT NOT NULL,
  id_idioma INT NOT NULL,
  UNIQUE (id_solicitud, id_idioma),
  FOREIGN KEY (id_solicitud) REFERENCES solicitudes_union(id_solicitud) ON DELETE CASCADE,
  FOREIGN KEY (id_idioma) REFERENCES idiomas(id_idioma)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Índices explícitos (campos de filtrado / ordenamiento frecuente)
-- -----------------------------------------------------
CREATE INDEX idx_publicaciones_tipo_fecha ON publicaciones(id_tipo, created_at);
CREATE INDEX idx_comentarios_publicacion_fecha ON comentarios(id_publicacion, created_at);
