#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);

my $x;
my $y;
my @nums;

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
    if ($x > $y){
        my $n = $x;
        $x = $y;
        $y = $n;
    }
    my @list = ($x..$y);
    # my 
    # for ($i = my $x; $i < my $y; $i++) {
    #     push(@list, i);
    # }
    return @list;
}

sub filter {
    my @list = ();
    foreach my $i (@nums){
        if (is_happy($i)){
            # print "$i\n";
            push(my @list, $i);
            print scalar @list,"\n";
        }
    }
    return my @list;
}

print "First argument: ";
$x = <>;
print "Second argument: ";
$y = <>;

if ($x == $y){
    print "NOBODYS HAPPY\n";
}

@nums = fillArray($x, $y);
print "@nums";
my @filtered = filter(@nums);
# print "@filtered";