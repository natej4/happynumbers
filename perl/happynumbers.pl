#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);

sub is_happy {
    my ($n) = @_;
    my %seen;
    while (1) {
        $n = sum map { $_ ** 2 } split //, $n;
        return 1 if $n == 1;
        return 0 if $seen{$n}++;
    }
}

sub fillArray {
    if (my $x > my $y){
        my $n = $x;
        $x = $y;
        $y = $n;
    }
    my @list = (my $x.. my $y);
    # my 
    # for ($i = my $x; $i < my $y; $i++) {
    #     push(@list, i);
    # }
    return @list;
}

print "First argument: ";
my $x = <>;
print "Second argument: ";
my $y = <>;

if ($x == $y){
    print "NOBODYS HAPPY\n";
}

print(fillArray($x, $y));