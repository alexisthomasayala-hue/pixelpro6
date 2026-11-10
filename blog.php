<?php
$titulo_pagina = "Castor7 - Blog Oficial | PixelPro🎮";
require_once 'includes/header.php';
?>

    <div class="contenido-principal">
        <h1>PixelPro🎮 - Blog de Videojuegos: Castor7</h1>
        <h2>Nuevo lanzamiento: Castor7, estrategia y supervivencia en el bosque</h2>  
        <img src="img/image 9.png" alt="Imagen oficial del juego Castor7">
        
        <p>No solo eres un castor; eres el líder de una colonia que lucha por prosperar en un bosque vibrante pero lleno de desafíos. Tras una gran tormenta que destruyó los antiguos diques, tu misión es reconstruir el hogar de tu familia desde cero, tronco a tronco.</p>
        <p>A lo largo de la partida, tendrás que planificar la tala de árboles, construir complejas redes de canales de agua y administrar los suministros antes de que llegue el invierno.</p>
    </div>

    <div class="seccion-comentarios">
        <h3>Comentarios de la comunidad</h3>
        <div class="comentario">
            <h4>Hector Estrada:</h4>
            <p>Tiene gráficos increíbles, mundo abierto y misiones desafiantes que ponen a prueba tu estrategia.</p>
        </div>
        <div class="comentario">
            <h4>Xxmclovinn123xX:</h4>
            <p>Buenos gráficos, buena historia, buena trama..... todo eso le falta XDDDDD sea serio</p>
        </div>
    </div>

    <!-- Galería de Imágenes Ordenada -->
    <div class="galeria-contenedor">
        <h3>Galería de Castor7</h3>
        <div class="miniaturas">
            <img src="img/image 1.png" alt="Castor 1" class="galeria-img">
            <img src="img/image 3.png" alt="Castor 3" class="galeria-img">
            <img src="img/image 4.png" alt="Castor 4" class="galeria-img">
            <img src="img/image 5.png" alt="Castor 5" class="galeria-img">
            <img src="img/image 6.png" alt="Castor 6" class="galeria-img">
            <img src="img/image 7.png" alt="Castor 7" class="galeria-img">
            <img src="img/image 9.png" alt="Castor 9" class="galeria-img">
            <img src="img/image 10.png" alt="Castor 10" class="galeria-img">
        </div>
    </div>

    <!-- Modal Limpio y Ordenado para el Zoom -->
    <div id="modalZoom" class="modal-galeria">
        <button id="btnAnterior" class="btn-control">❮</button>
        <div class="modal-contenido-imagen">
            <img id="imagenAmpliada" src="" alt="Imagen Ampliada">
        </div>
        <button id="btnSiguiente" class="btn-control">❯</button>
    </div>

<?php 
require_once 'includes/nav.php';
require_once 'includes/footer.php'; 
?>