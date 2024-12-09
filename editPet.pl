#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use DBI;

# Configuración CGI y cabeceras
my $cgi = CGI->new;

# Leer datos del formulario enviados por AJAX
my $params = $cgi->Vars;

print $cgi->header(-type => 'text/html', -location => 'loginPets.pl');

# Conectar a la base de datos
my $dbh = DBI->connect("DBI:mysql:database=pets;host=localhost", "perl_user", "perl_user", { RaiseError => 1, AutoCommit => 1 });

# Construir la consulta dinámicamente
my @fields;
my @values;

if ($params->{name}) {
    push @fields, "name = ?";
    push @values, $params->{name};
}
if ($params->{owner}) {
    push @fields, "owner = ?";
    push @values, $params->{owner};
}
if ($params->{species}) {
    push @fields, "species = ?";
    push @values, $params->{species};
}
if ($params->{sex}) {
    push @fields, "sex = ?";
    push @values, $params->{sex};
}
if ($params->{birth}) {
    push @fields, "birth = ?";
    push @values, $params->{birth};
}
if ($params->{death}) {
    push @fields, "death = ?";
    push @values, $params->{death};
}

# Añadir el ID a los valores
push @values, $params->{id};

# Preparar y ejecutar la consulta SQL
my $sql = "UPDATE pets SET " . join(", ", @fields) . " WHERE id = ?";
my $sth = $dbh->prepare($sql);
my $success = $sth->execute(@values);


# Cerrar conexión
$dbh->disconnect;

