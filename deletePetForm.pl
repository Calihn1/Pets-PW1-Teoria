#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
binmode STDOUT, ':utf8';

print "Content-type: text/html\n\n";

print <<'EOF';
<form id="deletePetForm" action="deletePet.pl" method="POST">
  <div class="form-group">
    <label for="id">ID:</label>
    <input type="text" class="form-control" id="id" name="id" required>
  </div>
  <button type="submit" class="btn btn-danger">Delete</button>
</form>
EOF
