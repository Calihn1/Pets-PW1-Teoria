#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use DBI;

# Configuración CGI y cabeceras
my $cgi = CGI->new;

# Configurar la cabecera para redirigir
print $cgi->header(-type => 'text/html', -location => 'loginPet.pl');

# Leer datos del formulario enviados por AJAX
my $params = $cgi->Vars;

# Conectar a la base de datos
my $dbh = DBI->connect("DBI:mysql:database=pets;host=localhost", "perl_user", "perl_user", { RaiseError => 1, AutoCommit => 1 });

# Preparar la consulta SQL para actualizar la información
my $sth = $dbh->prepare(
    "UPDATE pets SET owner = ?, species = ?, sex = ?, birth = ?, death = ? WHERE name = ?"
);

# Ejecutar la consulta con los datos enviados
my $success = $sth->execute(
    $params->{owner},
    $params->{species},
    $params->{sex},
    $params->{birth},
    $params->{death} || undef,
    $params->{name}
);

# Cerrar conexión
$dbh->disconnect;
