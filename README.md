TP6 – Base de Datos Relacional de PixelPro🎮

Diseño, normalización y creación de la base de datos MySQL del Proyecto Integrador PixelPro, un sitio web de una empresa de videojuegos con blog, noticias, comentarios de la comunidad, registro de usuarios y formulario para unirse al equipo.

Esta base de datos es el insumo para el TP7, donde se conectará la aplicación PHP con MySQL usando consultas preparadas (PDO).

📁 Contenido de la carpeta
Archivo	Descripción
NORMALIZACION.md	Parte 1: proceso de normalización (sin normalizar → 1FN → 2FN → 3FN) y listado de tablas con PK y FK.
schema.sql	Parte 2: script DDL que crea la base de datos pixelpro_db, las tablas, las claves foráneas y los índices.
consultas.sql	Parte 3: sentencias CRUD de prueba (INSERT, SELECT con WHERE/ORDER BY, INNER JOIN, UPDATE y DELETE).
README.md	Este documento.
⚙️ Requisitos
XAMPP o Laragon (MySQL 5.7+ o MariaDB)
phpMyAdmin (incluido en XAMPP y Laragon)
▶️ Cómo ejecutar los scripts
Iniciar Apache y MySQL desde XAMPP (o Iniciar todo en Laragon).
Abrir http://localhost/phpmyadmin.
Ir a la pestaña Importar, seleccionar tp6/schema.sql y presionar Continuar. Se crea la base pixelpro_db con sus 11 tablas.
Repetir el paso anterior con tp6/consultas.sql. Carga los datos de prueba y ejecuta las consultas.

⚠️ consultas.sql se ejecuta una sola vez sobre la base vacía (usa IDs fijos). Para repetirlo, eliminar la base pixelpro_db y volver a ejecutar schema.sql.

Alternativa: en la pestaña SQL de phpMyAdmin, pegar el contenido de cada archivo y presionar Continuar.

🗄️ Estructura de la base de datos
Tablas
Tabla	Tipo	Descripción
roles	Maestra	Administrador, Jugador
generos_usuario	Maestra	Género declarado en el registro
categorias_juego	Maestra	Acción y Supervivencia, Acción y Hordas, etc.
tipos_publicacion	Maestra	Blog, Noticia
idiomas	Maestra	Idiomas del formulario "Deseas unirte"
usuarios	Principal	Autenticación (email, password), rol y datos personales
juegos	Principal	Catálogo de juegos (Castor7, 7 Days to Die, etc.)
publicaciones	Negocio	Entradas de blog y noticias
comentarios	Detalle	Comentarios de la comunidad en cada publicación
solicitudes_union	Principal	Postulaciones del formulario "Deseas unirte"
solicitud_idioma	Relación N:M	Une solicitudes con idiomas
