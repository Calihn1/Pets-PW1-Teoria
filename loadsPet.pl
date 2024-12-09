#!/usr/bin/perl

use strict;
use warnings;
use DBI;
use JSON::XS;
use open ':std', ':encoding(UTF-8)';  # Asegura que la salida es UTF-8

print "Content-type: application/json; charset=UTF-8\n\n";

# Configuración de la conexión a MySQL
my $dsn = "DBI:mysql:database=pets;host=localhost;port=3306";
my $usuario = "perl_user";
my $contrasena = "perl_user";  # Cambia estos valores según tu configuración

# Conectar a la base de datos
my $dbh = DBI->connect(
    $dsn,
    $usuario,
    $contrasena,
    { RaiseError => 1, AutoCommit => 1, mysql_enable_utf8mb4 => 1 }
) or die "No se puede conectar a la base de datos: $DBI::errstr";


# Realizar la consulta
my $sth = $dbh->prepare("SELECT * FROM pets");
$sth->execute();

# Almacenar los resultados en un array de hashes
my @pets;
while (my $row = $sth->fetchrow_hashref) {
    push @pets, {
        id      => $row->{id},
        name    => $row->{name},
        owner   => $row->{owner},
        species => $row->{species},
        sex     => $row->{sex},
        birth   => $row->{birth},
        death   => $row->{death} || 'N/A',  # Si 'death' es NULL, poner 'N/A'
    };
}

# Codificar en formato JSON
my $json = JSON::XS->new->utf8(0)->encode(\@pets);

# Imprimir los datos en JSON
print $json;

# Liberar recursos
$sth->finish();
$dbh->disconnect();
