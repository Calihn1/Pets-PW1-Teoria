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
    <label for="name">Name:</label>
    <input type="text" class="form-control" id="name" name="name" required>
  </div>
  <div class="form-group">
    <label for="owner">Owner:</label>
    <input type="text" class="form-control" id="owner" name="owner" >
  </div>
  <div class="form-group">
    <label for="sex">Sex:</label>
    <select class="form-control" id="sex" name="sex" >
      <option value="" disabled selected>Select sex</option>
      <option value="male">Male</option>
      <option value="female">Female</option>
    </select>
  </div>
  <div class="form-group">
    <label for="species">Species:</label>
    <input type="text" class="form-control" id="species" name="species" >
  </div>
  <div class="form-group">
    <label for="birth">Birth:</label>
    <input type="date" class="form-control" id="birth" name="birth" >
  </div>
  <div class="form-group">
    <label for="death">Death (optional):</label>
    <input type="date" class="form-control" id="death" name="death">
  </div>
  <button type="submit" class="btn btn-danger">Delete</button>
</form>
EOF
