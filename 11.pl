#!/bin/perl

use strict;

my %floors = ('first' => 0, 'second' => 1, 'third' => 2, 'fourth' => 3);
my @floors = ([], [], [], []);
my $objects;
my $e; # floor of the elevator

while(<>) {
  /(first|second|third|fourth) floor contains (.+)/ or die "Invalid input: $_";

  my $floor = $floors{$1};

  if ($2 !~ /nothing/) {
    $floors[$floor] = [ map {
      /a (..).+((-compatible microchip)|( generator))/;

      $objects++;
      uc $1 . ($3 ? 'M' : 'G');
    } split(/ and |, and |, /, $2) ];
  }
}

$e = 0;

sub draw {
  my($e, $floors) = @_;

  print ("-" x (($objects+1) * 7)) . "\n";
  print "\n";
  for(my $floor = 3; $floor >= 0; $floor--) {
    print "F$floor ";
    print $floor == $e ? "   E   " : "   .   ";

    for(my $i = 0; $i < $objects; $i++) {
      print $floors->[$floor][$i] ? '  ' . $floors->[$floor][$i] . '  ' : '   .   ';
    }

    print "\n";
  }
}

sub cando {
  my %g = ();
  my %m = ();

  foreach my $part (@_) {
    my $el = substr $part, 0, 2;
    my $type = substr $part, 2, 1;

    $m{$el} = 1 if $type eq 'M';
    $g{$el} = 1 if $type eq 'G';
  }

  my @m = keys %m;
  my @g = keys %g;

  print "M: " . join(' ', @m) . "\t";
  print "G: " . join(' ', @g) . "\n";

  foreach my $g (@g) {
    delete $m{$g};
  }

  my $result = (keys %g) == 0 || (keys %m) == 0;

  print "M: " . join(' ', keys %m) . "\t";
  print "G: " . join(' ', keys %g) . "\n";

  print $result ? "OK\n" : "FAIL\n";

  return $result;
}

sub movetwo {
  my ($e, $move, $current, $previous, $lvl) = @_;

  for(my $i = 1; $i < @{$current->[$e]}; $i++) {
    for(my $j = 0; $j < $i; $j++) {
      print "$j, $i\n";

      my @oldset = @{$current->[$e]};
      my @newset = @{$current->[$move]};

      push @newset, (splice @oldset, $i, 1);
      push @newset, (splice @oldset, $j, 1);

      if(cando(@newset) && cando(@oldset)) {
        my @news = [@$current];

        $news[$e] = [@oldset];
        $news[$move] = [@newset];

        return 1 if &process($move, [@news], [@$current], $lvl + 1);
      }
    }
  }
}

sub moveone {
  my ($e, $move, $current, $previous, $lvl) = @_;

  for(my $i = 1; $i < @{$current->[$e]}; $i++) {
    my @oldset = @{$current->[$e]};
    my @newset = @{$current->[$move]};

    push @newset, (splice @oldset, $i, 1);

    if(cando(@newset) && cando(@oldset)) {
      my @news = [@$current];

      $news[$e] = [@oldset];
      $news[$move] = [@newset];
        print "old: " . join(' ', @oldset) . "  new: "  . join(' ', @news). "\n";

      return 1 if &process($move, [@news], [@$current], $lvl + 1);
    }
  }
}

sub process {
  my ($e, $current, $previous, $lvl) = @_;

  if($e == 3 && @{$current->[3]} == $objects) {
    print "Done. Level: $lvl\n";
    exit 0;
  }

  draw $e, $current;

  # Generally moving up
  # Need at least one microchip or generator to move.
  # May not have more than two things.
  # Microchips may coexist with other microchips but not RTGs without their own
  # May not contain a microchip and incompatible generator
  # May not result in a state where there is a microchip and incompatible generator
  # on the same floor

  if($e < 3) {
    my $move = $e + 1;

    return 1 if movetwo $e, $move, $current, $previous, $lvl;
    return 1 if moveone $e, $move, $current, $previous, $lvl;
  }

  if($e > 0) {
    my $move = $e - 1;

    return 1 if moveone $e, $move, $current, $previous, $lvl;
    return 1 if movetwo $e, $move, $current, $previous, $lvl;
  }

  return 0;
}

my $dir = 1;

draw 0, \@floors;

process(0, [@floors], [@floors], 0);

