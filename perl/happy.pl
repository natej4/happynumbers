#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);

#Asks the user for two positive integers
#and returns the 10 happy numbers between them
#with the greatest norms, sorted descending by the norms

#by Nate Jackson for CSC330

#globals (which I know aren't great but it works so)
my $x;
my $y;
my @nums;
my @filtered;
my @final;
my %map;

#determines whether a number is happy
sub is_happy {
    my ($n) = @_;
    my %seen;
    while (1) {
        $n = sum map { $_ ** 2 } split //, $n;
        return 1 if $n == 1;
        return 0 if $seen{$n}++;
    }
}

#fills an array with numbers between entered values
sub fillArray {
    if ($x > $y){
        my $n = $x;
        $x = $y;
        $y = $n;
    }
    my @list = ($x..$y);
    return @list;
}

#fills a new array with only number that are happy from fillArray
sub filter {
    foreach my $i (@nums){
        if (is_happy($i)){
            push(@filtered, ($i));
        }
    }
}

#inserts number and its norm into a hash, then sorts a list of the keys(numbers)
#by the norm (desc), then slices the first 10 values
sub sortNorms {
    my $norm;
    if (@filtered == 0){
        print "NOBODYS HAPPY\n";
        exit
    }

    foreach my $i (@filtered){
        $norm = norm($i);
        $map{$i} = $norm;
    }

    my @sorted = sort {$map{$b} <=> $map{$a}} keys %map;
    @final = @sorted[0..9];
}

#calculates the norm of a number (provided it is happy)
sub norm {
    my $num = $_[0];
    my %cache;
    my $output = 0.0;
    my $d = 0;
    while ($num > 1) {
        $cache{$num} = 1;
        my $m = 0;
        while ($num > 0) {
            $d = $num % 10;
            $m += $d*$d;
            $num = $num / 10;
        }
        $num = $m;
    }
    my @norms = keys %cache;
    foreach my $j (@norms) {
        $j = $j * $j;
        $output += $j;
    }
    return sqrt($output);
}


#main
print "First argument: ";
$x = <>;
print "Second argument: ";
$y = <>;

if ($x == $y){
    print "NOBODYS HAPPY\n";
    exit
}

@nums = fillArray($x, $y);
filter();
sortNorms();
foreach my $n (@final) {
    print "$n\n";
}
