# TP6 – Normalización de la base de datos de PixelPro🎮

Proyecto: sitio web de PixelPro (empresa de videojuegos) con blog, noticias, comentarios de la comunidad, registro de usuarios (`formulario.php`) y formulario para unirse al equipo (`deseas_unirte.php`).

---

## 1. Entidad principal sin normalizar

Registro hipotético de una **publicación del blog** tal como se vería "todo junto" (por ejemplo en una planilla):

| id_publicacion | titulo | tipo | autor_nombre | autor_email | juego | categoria_juego | comentarios |
|---|---|---|---|---|---|---|---|
| 1 | Nuevo lanzamiento: Castor7 | Blog | Admin PixelPro | admin@pixelpro.com | Castor7 | Estrategia y Supervivencia | Hector Estrada: "Tiene gráficos increíbles..." ; Xxmclovinn123xX: "Buenos gráficos, buena historia..." |

**Problemas detectados**

- `comentarios` es un campo **multivalorado**: guarda varios comentarios (con su autor) en una sola celda.
- **Redundancia**: si el mismo autor publica 50 entradas, se repiten su nombre y email 50 veces. Lo mismo pasa con el juego, su categoría y el tipo de publicación.
- **Anomalías**: si cambia el nombre de una categoría hay que modificarla en muchas filas (actualización); si se borra la única publicación de un juego se pierde la categoría (eliminación).

---

## 2. Proceso de normalización

### 1FN – Valores atómicos, sin grupos repetitivos

Se separa cada comentario en su propia fila. La clave pasa a ser compuesta: `(id_publicacion, id_comentario)`.

**publicacion_comentario**

| id_publicacion | id_comentario | titulo | tipo | autor_nombre | autor_email | juego | categoria_juego | comentario_autor | comentario_texto |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 1 | Nuevo lanzamiento: Castor7 | Blog | Admin PixelPro | admin@pixelpro.com | Castor7 | Estrategia y Supervivencia | Hector Estrada | Tiene gráficos increíbles... |
| 1 | 2 | Nuevo lanzamiento: Castor7 | Blog | Admin PixelPro | admin@pixelpro.com | Castor7 | Estrategia y Supervivencia | Xxmclovinn123xX | Buenos gráficos, buena historia... |

Ahora cada campo tiene un solo valor. Aun así hay mucha repetición (el título, el autor y el juego se repiten en cada comentario).

> Mismo criterio para `deseas_unirte.php`: el campo **Idiomas** puede tener varios valores ("Español, Inglés"). Se resuelve con una tabla de idiomas y una tabla intermedia (relación N:M).

### 2FN – Sin dependencias parciales de la clave compuesta

Clave: `(id_publicacion, id_comentario)`.

- `titulo`, `tipo`, `autor_*`, `juego`, `categoria_juego` dependen **solo de `id_publicacion`** (parte de la clave) → pasan a la tabla **publicaciones**.
- `comentario_autor` y `comentario_texto` dependen de `id_comentario` → quedan en **comentarios**, con `id_publicacion` como clave foránea.

Resultado:

**publicaciones**(id_publicacion, titulo, tipo, autor_nombre, autor_email, juego, categoria_juego)
**comentarios**(id_comentario, id_publicacion, comentario_autor, comentario_texto)

### 3FN – Sin dependencias transitivas

Se eliminan los atributos no-clave que dependen de otro atributo no-clave:

- `autor_nombre`, `autor_email` dependen del autor, no de la publicación → tabla **usuarios** (y `id_autor` en publicaciones). Lo mismo para `comentario_autor` → `id_usuario` en comentarios.
- `categoria_juego` depende de `juego` (`id_publicacion → juego → categoria_juego`) → tablas **juegos** y **categorias_juego**.
- `tipo` (Blog / Noticia) → tabla **tipos_publicacion**.
- En usuarios: el **rol** y el **género** se extraen a **roles** y **generos_usuario** (evita repetir texto y errores de escritura).

---

## 3. Listado de tablas resultante

| Tabla | PK | FK | Descripción |
|---|---|---|---|
| roles | id_rol | — | Administrador, Jugador |
| generos_usuario | id_genero | — | Género declarado en el registro |
| categorias_juego | id_categoria | — | Acción y Supervivencia, Hordas, etc. (página *Géneros*) |
| tipos_publicacion | id_tipo | — | Blog, Noticia |
| idiomas | id_idioma | — | Idiomas del formulario "Deseas unirte" |
| usuarios | id_usuario | id_rol → roles, id_genero → generos_usuario | Autenticación y datos personales |
| juegos | id_juego | id_categoria → categorias_juego | Castor7, 7 Days to Die, etc. |
| publicaciones | id_publicacion | id_autor → usuarios, id_tipo → tipos_publicacion, id_juego → juegos | Entradas de blog y noticias |
| comentarios | id_comentario | id_publicacion → publicaciones, id_usuario → usuarios | Comentarios de la comunidad |
| solicitudes_union | id_solicitud | id_usuario → usuarios | Formulario "Deseas unirte" |
| solicitud_idioma | id_solicitud_idioma | id_solicitud → solicitudes_union, id_idioma → idiomas | Relación N:M solicitud ↔ idiomas |

### Diagrama de relaciones

```
roles 1───N usuarios N───1 generos_usuario
usuarios 1───N publicaciones N───1 tipos_publicacion
juegos   1───N publicaciones
categorias_juego 1───N juegos
publicaciones 1───N comentarios N───1 usuarios
usuarios 1───N solicitudes_union N───M idiomas  (vía solicitud_idioma)
```
