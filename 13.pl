#!/bin/perl

use strict;
use Data::Dumper qw(Dumper);

my $input = 1352;

sub clear {
  my ($x, $y) = @_;

  return 0 if $x < 0 || $y < 0;

  my $count = 0;
  my $num = $x*$x + 3*$x + 2*$x*$y + $y + $y*$y;

  $num += $input;

  while($num) {
    $count += $num & 1;
    $num = $num >> 1;
  }

  print "($x, $y)=($count % 2)=" . ($count % 2) . "\n";
  return ($count % 2 == 0);
}

my ($gx, $gy) = (31, 39);
my %state = ();

sub find {
  my %cur = @_;
  my %ret = ();

  foreach my $p (keys %cur) {
    my ($x, $y) = split '-', $p;

    foreach my $move (([1, 0], [0, 1], [-1, 0], [0, -1])) {
      my ($nx, $ny) = ($x + $move->[0], $y + $move->[1]);

      if(!$state{"$nx-$ny"} && clear($nx, $ny)) {
        $state{"$nx-$ny"} = 1;
        $ret{"$nx-$ny"} = 1;
      }
    }
  }

  return %ret;
}

my %found = ('1-1' => 1);
my $steps = 0;
my $p2;

while(!$found{'31-39'}) {
  $steps++;
  %found = find(%found);
  print "$steps: " . join(' ', keys %found) . "\n";

  if($steps == 50) {
    $p2 = (keys %state);
  }
}

print "Steps: $steps\n";
print "P2: $p2\n";

