#!/bin/perl

@f=qw(-3 3 -1 1);
$pos = 5;

while(<>) {
	chomp;

	map {
		$dir = $_;
		tr/UDLR/0123/;

		unless(
			# Can't go further up
			($_ == 0 && ($pos < 3 || $pos == 4 || $pos == 5 || $pos == 9)) || 
			#       " down
			($_ == 1 && ($pos > 11 || $pos == 10 || $pos == 5 || $pos == 9)) ||
			#       " left
			($_ == 2 && ($pos < 3 || $pos == 5 || $pos == 10 || $pos == 14)) ||
			#       " right
			($_ == 3 && ($pos > 11 || $pos == 9 || $pos == 4 || $pos == 1))
		) {
			if($_ == 0) {
				if($pos == 3) { $pos = 1; }
				elsif($pos < 14) { $pos -= 4; }
				else { $pos = 11; }
			}
			elsif($_ == 1) {
				if($pos == 11) { $pos = 14; }
				elsif($pos > 1) { $pos += 4; }
				else { $pos = 3; }
			}
			elsif($_ == 2) {
				$pos -= 1;
			}
			elsif($_ == 3) {
				$pos += 1;
			}
		}

		print "$dir ($_) $pos\t";
	} split //;

	print "\nKey: $pos\n";
}

