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

# Construir la consulta SQL dinámicamente
my $sql = "DELETE FROM pets WHERE name = ?";
my @bind_values = ($params->{name});

# Agregar condiciones dinámicamente para cada parámetro
foreach my $field (qw(owner sex species birth death)) {
    if (defined $params->{$field} && $params->{$field} ne '') {
        $sql .= " AND $field = ?";
        push @bind_values, $params->{$field};
    } else {
        $sql .= " AND $field IS NULL";
    }
}

# Preparar y ejecutar la consulta
my $sth = $dbh->prepare($sql);
my $rows_deleted = $sth->execute(@bind_values);

# Cerrar la conexión a la base de datos
$dbh->disconnect;
