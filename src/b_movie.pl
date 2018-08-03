#!/usr/bin/perl -w

use strict;
use List::Util qw/shuffle/;

my $predator = get_predator();
my $disaster = get_disaster();
printf "%s %s\n", ucfirst $predator, $disaster;

sub get_predator {
    my $predators;
    my $predator = 'Shark';
    my $fh;

    $predators = {};
    if(open($fh, 'curl https://en.wikipedia.org/wiki/List_of_apex_predators 2> /dev/null |')) {
        while(<$fh>) {
            while(/<a\s.*?>(.*?)<\/a>\s*\(<i>.*?<\/i>/g) {
                $predators->{$1}++;
            }
        }
        close($fh);
        #$predators = [shuffle keys %{$predators}];
        $predator = lc [shuffle keys %{$predators}]->[0];
    }

    return $predator;
}

sub get_disaster {
    my $disasters;
    my $disaster = 'Tornado';
    my $fh;

    $disasters = {};
    if(open($fh, 'curl https://en.wikipedia.org/wiki/Natural_disaster 2> /dev/null |')) {
        while(<$fh>) {
            while(/<h3><span class="mw-headline" id=".*?">(.*?)<\/span>/g) {
                $disasters->{$1}++;
            }
        }
        close($fh);
        #$disasters = [shuffle keys %{$disasters}];
        $disaster = lc [shuffle keys %{$disasters}]->[0];
    }

    return $disaster;
}
