#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw(:all);
use List::Util;

my $count = 1000000;

my $r = timethese($count,
    {'single' => '&test1;', 'double' => '&test2;', });

cmpthese $r;

sub test1 {
  my $test = 'abcdef';
}

sub test2 {
  my $test = "abcdef";
}

__END__

