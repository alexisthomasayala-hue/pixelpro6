<?php
$titulo_pagina = "Registro | PixelPro🎮";
require_once 'includes/header.php';

// Inicialización de variables para persistencia y errores
$errores = [];
$exito = "";

$nombre = "";
$email = "";
$fecha_nacimiento = "";
$genero = "";

// Procesamiento del Formulario vía POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. Sanitización de entradas con trim y htmlspecialchars / filter_input (Prevención XSS)
    $nombre = filter_input(INPUT_POST, 'nombre', FILTER_SANITIZE_SPECIAL_CHARS);
    $nombre = $nombre ? trim($nombre) : '';

    $email_raw = filter_input(INPUT_POST, 'email', FILTER_DEFAULT);
    $email = $email_raw ? trim(htmlspecialchars($email_raw, ENT_QUOTES, 'UTF-8')) : '';

    $password = filter_input(INPUT_POST, 'password', FILTER_DEFAULT); // Las contraseñas no se persisten por seguridad

    $fecha_nacimiento = filter_input(INPUT_POST, 'fecha_nacimiento', FILTER_SANITIZE_SPECIAL_CHARS);
    $fecha_nacimiento = $fecha_nacimiento ? trim($fecha_nacimiento) : '';

    $genero = filter_input(INPUT_POST, 'genero', FILTER_SANITIZE_SPECIAL_CHARS);
    $genero = $genero ? trim($genero) : '';

    $terminos = isset($_POST['terminos']) ? true : false;

    // 2. Validación en Servidor
    if (empty($nombre)) {
        $errores[] = "El nombre completo es obligatorio.";
    }

    if (empty($email)) {
        $errores[] = "El correo electrónico es obligatorio.";
    } elseif (!filter_var($email_raw, FILTER_VALIDATE_EMAIL)) {
        $errores[] = "El formato del correo electrónico no es válido.";
    }

    if (empty($password)) {
        $errores[] = "La contraseña es obligatoria.";
    } elseif (strlen($password) < 6) {
        $errores[] = "La contraseña debe tener al menos 6 caracteres.";
    }

    if (!$terminos) {
        $errores[] = "Debes aceptar los términos y condiciones.";
    }

    // 3. Respuesta al usuario
    if (empty($errores)) {
        $exito = "¡Registro completado con éxito! Bienvenido a PixelPro, " . $nombre . ".";
        // Limpiar campos tras éxito
        $nombre = $email = $fecha_nacimiento = $genero = "";
    }
}
?>

    <div class="contenedor-formulario" style="max-width: 600px; margin: 20px auto; padding: 20px;">
        <h1>PixelPro🎮 - Registro de Usuario (Procesado por PHP POST)</h1>

        <!-- Mensajes de Retroalimentación en la Interfaz -->
        <?php if (!empty($exito)): ?>
            <div style="background-color: #d4edda; color: #155724; padding: 12px; margin-bottom: 15px; border-radius: 5px;">
                <strong>✅ ¡Éxito!</strong> <?= $exito; ?>
            </div>
        <?php endif; ?>

        <?php if (!empty($errores)): ?>
            <div style="background-color: #f8d7da; color: #721c24; padding: 12px; margin-bottom: 15px; border-radius: 5px;">
                <strong>⚠️ Corrija los siguientes errores:</strong>
                <ul style="margin: 5px 0 0 20px;">
                    <?php foreach ($errores as $error): ?>
                        <li><?= $error; ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <!-- Formulario POST con Persistencia de datos ($nombre, $email, etc.) -->
        <form action="formulario.php" method="POST">
            <div style="margin-bottom: 15px;">
                <label for="nombre">Nombre completo:</label><br>
                <input type="text" id="nombre" name="nombre" value="<?= $nombre; ?>" style="width: 100%; padding: 8px;">
            </div>

            <div style="margin-bottom: 15px;">
                <label for="email">Correo electrónico:</label><br>
                <input type="email" id="email" name="email" value="<?= $email; ?>" style="width: 100%; padding: 8px;">
            </div>

            <div style="margin-bottom: 15px;">
                <label for="password">Contraseña:</label><br>
                <input type="password" id="password" name="password" style="width: 100%; padding: 8px;">
            </div>

            <div style="margin-bottom: 15px;">
                <label for="fecha_nacimiento">Fecha de nacimiento:</label><br>
                <input type="date" id="fecha_nacimiento" name="fecha_nacimiento" value="<?= $fecha_nacimiento; ?>" style="padding: 8px;">
            </div>

            <div style="margin-bottom: 15px;">
                <label style="display:block; margin-bottom: 5px;">Género:</label>
                <input type="radio" id="femenino" name="genero" value="femenino" <?= ($genero === 'femenino') ? 'checked' : ''; ?>>
                <label for="femenino" style="margin-right: 15px;">Femenino</label>
                <input type="radio" id="masculino" name="genero" value="masculino" <?= ($genero === 'masculino') ? 'checked' : ''; ?>>
                <label for="masculino">Masculino</label>
            </div>

            <div style="margin-bottom: 15px;">
                <input type="checkbox" id="terminos" name="terminos" value="1">
                <label for="terminos">Acepto los términos y condiciones</label>
            </div>

            <div>
                <button type="submit" style="padding: 10px 20px; cursor: pointer;">Registrarse</button>
            </div>
        </form>
    </div>

<?php 
require_once 'includes/nav.php';
require_once 'includes/footer.php'; 
?>