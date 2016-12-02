#!/bin/perl

@f=qw(-3 3 -1 1);
$pos = 5;

while(<>) {
	chomp;

	map {
		tr/UDLR/0123/;
		$d = $f[$_];
		$n = $pos + $d;

		# Can't go out of bounds
		$n = $pos if($n < 1 || $n > 9);

		# Can't go further left
		$n = $pos if($_ == 2 && $pos % 3 == 1);

		# Can't go further right
		$n = $pos if($_ == 3 && $pos % 3 == 0);

#		print "$_\t$pos\t$d=>$n\n";
		$pos = $n;
	} split //;

	print "$pos\n";
}

