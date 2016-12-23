#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw(:all);
use List::Util;

my $count = 1000000;

my $r = timethese($count,
    {'escape' => '&test1;', 'uc' => '&test2;', });

cmpthese $r;

sub test1 {
  my $test = "\Utest\E";
}

sub test2 {
  my $test = uc('test');
}

__END__

