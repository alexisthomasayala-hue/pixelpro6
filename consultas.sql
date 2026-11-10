-- =====================================================
-- consultas.sql - PixelPro🎮
-- Ejecutar DESPUÉS de schema.sql y sobre la base vacía
-- (los IDs usados en los INSERT asumen AUTO_INCREMENT desde 1)
-- =====================================================
USE pixelpro_db;

-- =====================================================
-- CREATE
-- =====================================================

-- Tablas maestras
INSERT INTO roles (nombre) VALUES ('Administrador'), ('Jugador');

INSERT INTO generos_usuario (nombre) VALUES ('Femenino'), ('Masculino');

INSERT INTO categorias_juego (nombre) VALUES
  ('Acción y Supervivencia'),
  ('Acción y Hordas'),
  ('Estrategia y Supervivencia');

INSERT INTO tipos_publicacion (nombre) VALUES ('Blog'), ('Noticia');

INSERT INTO idiomas (nombre) VALUES ('Español'), ('Inglés');

-- Usuarios (los password son hashes de ejemplo; en el TP7 se generan con password_hash())
INSERT INTO usuarios (nombre_completo, email, password, fecha_nacimiento, id_genero, acepto_terminos, id_rol) VALUES
  ('Admin PixelPro', 'admin@pixelpro.com', '$2y$10$hashDeEjemploAdminXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '1990-05-10', 2, 1, 1),
  ('Hector Estrada', 'hector@mail.com',    '$2y$10$hashDeEjemploHectorXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '1998-03-22', 2, 1, 2),
  ('Xxmclovinn123xX', 'mclovin@mail.com',  '$2y$10$hashDeEjemploMclovinXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '2001-11-02', 2, 1, 2);

INSERT INTO juegos (nombre, descripcion, id_categoria) VALUES
  ('Castor7', 'Estrategia y supervivencia: reconstruí la colonia de castores antes del invierno.', 3),
  ('7 Days to Die', 'Supervivencia en mundo abierto contra hordas de zombis.', 1),
  ('Back 4 Blood', 'Shooter cooperativo de hordas.', 2);

-- Tabla principal (2 inserciones con claves foráneas)
INSERT INTO publicaciones (titulo, contenido, imagen, id_autor, id_tipo, id_juego) VALUES
  ('Nuevo lanzamiento: Castor7, estrategia y supervivencia en el bosque',
   'Sos el líder de una colonia que lucha por prosperar en un bosque lleno de desafíos...',
   'img/image 9.png', 1, 1, 1),
  ('GTA VI confirma su lanzamiento para noviembre de 2026',
   'Rockstar Games confirmó que Grand Theft Auto VI llegará el 19 de noviembre de 2026...',
   NULL, 1, 2, NULL);

INSERT INTO comentarios (id_publicacion, id_usuario, texto) VALUES
  (1, 2, 'Tiene gráficos increíbles, mundo abierto y misiones desafiantes que ponen a prueba tu estrategia.'),
  (1, 3, 'Comentario de prueba para eliminar.');

INSERT INTO solicitudes_union (id_usuario, descripcion_personal, experiencia) VALUES
  (2, 'Apasionado por los videojuegos y el diseño de niveles.', '2 años como tester independiente');

INSERT INTO solicitud_idioma (id_solicitud, id_idioma) VALUES (1, 1), (1, 2);

-- =====================================================
-- READ
-- =====================================================

-- WHERE + ORDER BY: publicaciones de tipo Blog, de la más reciente a la más antigua
SELECT id_publicacion, titulo, created_at
FROM publicaciones
WHERE id_tipo = 1
ORDER BY created_at DESC;

-- INNER JOIN: título + autor + tipo + juego + categoría
SELECT p.titulo,
       u.nombre_completo AS autor,
       t.nombre AS tipo,
       j.nombre AS juego,
       c.nombre AS categoria
FROM publicaciones p
INNER JOIN usuarios u           ON p.id_autor = u.id_usuario
INNER JOIN tipos_publicacion t  ON p.id_tipo = t.id_tipo
INNER JOIN juegos j             ON p.id_juego = j.id_juego
INNER JOIN categorias_juego c   ON j.id_categoria = c.id_categoria
ORDER BY p.titulo;

-- INNER JOIN: comentarios de la publicación 1 con su autor
SELECT p.titulo, u.nombre_completo AS comentarista, co.texto, co.created_at
FROM comentarios co
INNER JOIN publicaciones p ON co.id_publicacion = p.id_publicacion
INNER JOIN usuarios u      ON co.id_usuario = u.id_usuario
WHERE p.id_publicacion = 1
ORDER BY co.created_at ASC;

-- =====================================================
-- UPDATE
-- =====================================================
UPDATE publicaciones
SET titulo = 'Castor7: ya disponible, estrategia y supervivencia en el bosque'
WHERE id_publicacion = 1;

-- =====================================================
-- DELETE
-- =====================================================
DELETE FROM comentarios
WHERE id_comentario = 2;
