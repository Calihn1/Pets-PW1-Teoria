#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use CGI;

# Configuración de CGI
my $cgi = CGI->new;
print $cgi->header('text/plain');

# Obtener datos del formulario enviado vía POST
my $username = $cgi->param('username') // '';
my $password = $cgi->param('password') // '';

# Validar entrada
if (!$username || !$password) {
    print "error";
    exit;
}

# Configuración de la base de datos
my $dbname = "registro";   # Nombre de la base de datos
my $host = "localhost";    # Host donde está la base de datos
my $port = "3306";         # Puerto de la base de datos
my $user = "perl_user";         # Usuario de la base de datos
my $pass = "perl_user";             # Contraseña de la base de datos

# Conexión a la base de datos
my $dsn = "DBI:mysql:database=$dbname;host=$host;port=$port";
my $dbh = DBI->connect($dsn, $user, $pass, { RaiseError => 1, PrintError => 0 });

# Consulta para verificar al usuario
my $sth = $dbh->prepare("SELECT * FROM usuario WHERE username = ? AND password = ?");
$sth->execute($username, $password);

if (my $row = $sth->fetchrow_hashref) {
    # Si las credenciales son correctas
    print "success";
} else {
    # Credenciales incorrectas
    print "error";
}

# Finalizar conexión
$sth->finish;
$dbh->disconnect;
