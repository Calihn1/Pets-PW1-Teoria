#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use DBI;

# Configuración CGI y cabeceras
my $cgi = CGI->new;

print $cgi->header(-type => 'text/html', -location => 'loginPets.pl');

# Leer datos del formulario enviados por AJAX
my $params = $cgi->Vars;

# Conectar a la base de datos
my $dbh = DBI->connect("DBI:mysql:database=pets;host=localhost", "perl_user", "perl_user", { RaiseError => 1, AutoCommit => 1 });

# Preparar y ejecutar la consulta
my $sth = $dbh->prepare("DELETE FROM pets WHERE id = ?");
$sth->execute( $params -> {id});

# Cerrar la conexión a la base de datos
$dbh->disconnect;
