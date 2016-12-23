#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw(:all);
use List::Util;

my $count = 1;
my $str = <<'SQL';
INSERT INTO ninja_user_mission_data
  (mission_id, mission_mst_all, mission_mst_flg, mission_step, ninja_id)
VALUES
  ('20202', '100', '1', '2', '157116596')
SQL

my $r = timethese($count, {'default' => '&test1;', 'mod' => '&test2;', });

cmpthese $r;

sub test1 {
  $str =~ s/^INSERT\s+INTO\s+/INSERT /i;
  my $col_str;
  my ( $table_name, $val_str );# = $str =~ m/^INSERT\s+(.+?)\s+VALUES\s+(\(.+?\))$/i;
  #if ( $table_name and $table_name =~ m/[()]/ ) {
  #  ( $table_name, $col_str, $val_str ) =
    $str =~ m/^INSERT\s+(.+?)\s+\((.+?)\)\s+VALUES\s+(\(.+?\))$/i;
    #}
  print $table_name, $col_str, $val_str;
}

sub test2 {
}

__END__

