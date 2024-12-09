#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use DBI;

my $cgi = CGI->new;

# Configurar la cabecera para redirigir
print $cgi->header(-type => 'text/html', -location => 'loginPets.pl');

# Leer datos del formulario
my $params = $cgi->Vars;

# Conectar a la base de datos
my $dbh = DBI->connect("DBI:mysql:database=pets;host=localhost", "perl_user", "perl_user", { RaiseError => 1 });

# Insertar datos en la tabla pets
my $sth = $dbh->prepare("INSERT INTO pets (name, owner, species, sex, birth, death) VALUES (?, ?, ?, ?, ?, ?)");
$sth->execute(
    $params->{name},
    $params->{owner},
    $params->{species},
    $params->{sex},
    $params->{birth},
    $params->{death} || undef
);

# Cerrar la conexión
$dbh->disconnect;