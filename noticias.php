<?php
$titulo_pagina = "Noticias | PixelPro🎮";
require_once 'includes/header.php';

// Captura sanitizada del término de búsqueda GET
$busqueda = isset($_GET['q']) ? htmlspecialchars(trim($_GET['q']), ENT_QUOTES, 'UTF-8') : '';
?>

    <div class="contenedor-noticias">
        <h1>Noticias PixelPro</h1>
        
        <?php if (!empty($busqueda)): ?>
            <div style="background-color: #e2e8f0; color: #1e293b; padding: 10px; margin-bottom: 15px; border-radius: 4px;">
                🔎 Resultados de búsqueda para: <strong><?= $busqueda; ?></strong>
            </div>
        <?php endif; ?>

        <hr>
        <p><strong>GTA VI confirma su lanzamiento para noviembre de 2026 tras nuevos ajustes en el calendario</strong></p>
        <p>VICE CITY – Rockstar Games ha sacudido nuevamente a la industria al confirmar que Grand Theft Auto VI (GTA VI) llegará oficialmente a las consolas de nueva generación el 19 de noviembre de 2026. Aunque inicialmente el título apuntaba a un estreno en mayo de este mismo año, el estudio ha decidido tomarse unos meses adicionales para garantizar el nivel de pulido y calidad visual que los fans esperan de la saga.</p>
    </div>
    <hr>

<?php 
require_once 'includes/nav.php';
require_once 'includes/footer.php'; 
?>