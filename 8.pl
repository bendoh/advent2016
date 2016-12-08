#!/bin/perl

use Data::Dumper qw(Dumper);

@map = ();

for($j = 0; $j < 6; $j++) {
	for($i = 0; $i < 50; $i++) {
		$map[$j][$i] = 0;
	}
}


while(<>) {
	print;
	chomp;

	if(/rect (\d+)x(\d+)/) {
		for($j = 0; $j < $1; $j++) {
			for($i = 0; $i < $2; $i++) {
				$map[$i][$j] = 1;
			}
		}
	}

	elsif(/rotate (row|column) (x|y)=(\d+) by (\d+)/) {
		if($1 eq 'row') {
			@new = @{$map[$3]};

			for($i = 0; $i < 50; $i++) {
				$new[$i] = $map[$3][($i - $4) % 50] || 0;
			}

			for($i = 0; $i < 50; $i++) {
				$map[$3][$i] = $new[$i];
			}
		}
		elsif($1 eq 'column') {
			@new = ();

			for($i = 0; $i < 6; $i++) {
				$new[$i] = $map[($i - $4) % 6][$3] || 0;
			}

			for($i = 0; $i < 6; $i++) {
				$map[$i][$3] = $new[$i];
			}
		}
	}


	for($j = 0; $j < 6; $j++) {
		for($i = 0; $i < 50; $i++) {
			print $map[$j][$i] ? '# ' : '  ';
		}
		print "\n";
	}

	print "\n";
}

$k = 0;

for($i = 0; $i < 50; $i++) {
	for($j = 0; $j < 6; $j++) {
		$k += $map[$j][$i];
	}
}


print "k=$k\n";
