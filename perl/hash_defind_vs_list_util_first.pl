#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw(:all);
use List::Util;

my $count = 1000000;

my $r = timethese($count,
    {'grep' => '&test1;', 'List::Util' => '&test2;', });

cmpthese $r;

sub test1 {
  my @datas = qw(apple orange banana);
  my %datas;
  $datas{$_} = 1 for @datas;
  grep { !exists $datas{'banana'} } @datas;
}

sub test2 {
  my @datas = qw(apple orange banana);
  grep { ! List::Util::first{$_ eq 'banana'} } @datas;
}

__END__

