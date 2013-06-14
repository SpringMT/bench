#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw(:all);
use Geo::IP;
use Geo::IP::PurePerl;

my $count = 10000;

my $r = timethese($count,
    {'C' => '&test1;', 'PurePerl' => '&test2;', });

cmpthese $r;

sub test1 {
    my $gi = Geo::IP->open("GeoLiteCity.dat", GEOIP_STANDARD);
    my $record = $gi->record_by_addr("");
    my $region = $record->region;
}

sub test2 {
    my $gi = Geo::IP::PurePerl->new("GeoLiteCity.dat", GEOIP_STANDARD);
    my $record = $gi->get_city_record_as_hash("");
    my $region = $record->{region};
}

__END__

