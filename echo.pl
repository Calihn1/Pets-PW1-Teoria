#!/usr/bin/perl

use strict;
use warnings;
use utf8;

use open ':std', ':encoding(UTF-8)';
binmode STDOUT, ':utf8';

print << 'EOF';
Content-type: text/html

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Login</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    body {
      background-color: #f8f9fa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .login-container {
      width: 100%;
      max-width: 400px;
      padding: 20px;
      background-color: #ffffff;
      border-radius: 8px;
      box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
    .error {
      color: red;
      display: none;
    }
  </style>
</head>
<body>
<div class="login-container">
  <h2 class="text-center">Login</h2>
  <form id="loginForm">
    <div class="form-group">
      <label for="username">Username:</label>
      <input type="text" class="form-control" id="username" name="username" required>
    </div>
    <div class="form-group">
      <label for="password">Password:</label>
      <input type="password" class="form-control" id="password" name="password" required>
    </div>
    <button type="submit" class="btn btn-primary btn-block">Log In</button>
  </form>
  <p class="error text-center" id="errorMsg">Error: Invalid username or password. Please try again.</p>
</div>

<script>
    $(document).ready(function() {
      $('#loginForm').on('submit', function(event) {
        event.preventDefault(); // Evitar el envío normal del formulario

        $.ajax({
          url: "login.pl", // Ruta del script Perl para procesar el login
          method: "POST",
          data: $(this).serialize(), // Enviar todos los datos del formulario como variables
          success: function(response) {
            // Manejar la respuesta
            if (response.includes('success=')) {
              window.location.href = "loginPets.pl"; // Redirigir a loginPets.pl
            } else if (response.includes('error=')) {
              $('#errorMsg').text(response.split('=')[1]).show(); // Mostrar error
            }
          },
          error: function() {
            alert('An error occurred. Please try again.');
          }
        });
      });
    });
</script>

</body>
</html>
EOF
