#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use DBI;

# Inicializar CGI
my $cgi = CGI->new;

# Enviar encabezado HTTP
print $cgi->header('text/plain');

# Capturar parámetros del formulario enviados por POST
my $username = $cgi->param('username') // '';
my $password = $cgi->param('password') // '';

# Validar entrada
if (!$username || !$password) {
    print "error=Missing username or password";
    exit;
}

# Conexión a la base de datos
my $dbname = "pets";
my $host = "localhost";
my $port = 3306;
my $db_user = "perl_user";
my $db_pass = "perl_user";

my $dsn = "DBI:mysql:database=$dbname;host=$host;port=$port";
my $dbh = DBI->connect($dsn, $db_user, $db_pass, { RaiseError => 1, PrintError => 0 });

# Consulta para verificar credenciales
my $sth = $dbh->prepare("SELECT * FROM usuario WHERE username = ? AND password = ?");
$sth->execute($username, $password);

if (my $row = $sth->fetchrow_hashref) {
    print "success=Login successful";
} else {
    print "error=Invalid username or password";
}

# Finalizar conexión
$sth->finish;
$dbh->disconnect;
