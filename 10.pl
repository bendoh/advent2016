#!/bin/perl

%values = ();
%instructions = ();
%output = ();

use Data::Dumper qw(Dumper);

sub give {
  my ($bot, $value) = @_;

  print "give $value to bot $bot values=";
  $values{$bot} = [] unless $values{$bot};

  $val = $values{$bot};

  if (@$val == 2) {
    die "too many values for bot $bot";
  }

  unshift @$val, $value;

  print join(' ', @$val) . "\n";
  if(@$val == 2) {
    &go($bot);
  }
}

sub output {
  my ($num, $value) = @_;

  print "outputting $value to $num\n";
  $output{$num} = $value;
}

sub go {
  my $bot = shift;

  if (!$instructions{$bot}) {
    die "No instruction for bot $bot";
  }

  my %inst = %{$instructions{$bot}};
  my @vals = @{$values{$bot}};

  my ($low, $high) = sort { $a <=> $b } @vals;

  $values{$bot} = [];

  print "$bot: $low / $high\n";

  if($low == 17 && $high == 61) {
    print "Bot $bot has $low/$high\n";
  }

  my ($out, $where) = split(/ /, $inst{'low'});

  if ($out eq 'output') {
    output $where, $low;
  }
  else {
    give $where, $low;
  }

  ($out, $where) = split(/ /, $inst{'high'});

  if ($out eq 'output') {
    output $where, $high;
  }
  else {
    give $where, $high;
  }

}

while(<>) {
  if(/value (\d+) goes to bot (\d+)/) {
    $values{$2} = [] unless $values{$2};
    push @{$values{$2}}, $1;
  }

  if(/bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/) {
    $instructions{$1}{'low'} = "$2 $3";
    $instructions{$1}{'high'} = "$4 $5";
  }
}

while(my ($bot, $values) = each %values) {
  if(@$values == 2) {
    go $bot;
    last;
  }
}

while (my($output, $value) = each %output) {
  print "output $output: $value\n";
}
