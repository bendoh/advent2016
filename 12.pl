#!/bin/perl

use strict;

my %regs = (c => 1);
my @instructions = map { chomp; $_ } <>;
my $i = 0;
my $j++;

sub printregs {
	foreach my $reg (keys %regs) {
		print "| $reg\t\t";
	}

	print "\n";

	foreach my $value (values %regs) {
		print "| $value\t\t";
	}

	print "\n";
}

while($i < @instructions) {
	$j++;
	$_ = $instructions[$i];

#	printregs();

#	print "$j\t$i\t$_\n";

	if(/cpy (\d+) (.+)/) {
		$regs{$2} = $1;
	}
	elsif(/cpy (\w+) (\w+)/) {
		$regs{$2} = $regs{$1};
	}
	elsif(/jnz (\d+) (-?\d+)/) {
		if($1) {
			$i += $2;
			next;
		}
	}
	elsif(/jnz (\w+) (-?\d+)/) {
		if($regs{$1}) {
			$i += $2;
			next;
		}
	}
	elsif(/dec (\w+)/) {
		$regs{$1}--;
	}
	elsif(/inc (\w+)/) {
		$regs{$1}++;
	}
	else {
		die "Bad instruction: $_";
	}

	$i++;
}

printregs;
