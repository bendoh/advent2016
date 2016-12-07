#!/bin/perl

while(<>) {
	/(.+)-(\d+)\[(.+)\]/;
	($name, $sector, $chk) = ($1, $2, $3);

	%count = ();
	@name = split //, $name;
	foreach $letter (@name) {
		next if $letter eq '-';
		$count{$letter}++;
	}

	@keys = sort { $count{$b} <=> $count{$a} || $a cmp $b } keys %count;

	if($chk eq join('', @keys[0..4])) {
		$count++;
		$sum += $sector;
		for($i = 0; $i < @name; $i++) {
			if($name[$i] eq '-') {
				$name[$i] = ' ';
			}
			else {
				$name[$i] = chr((ord($name[$i]) - ord('a') + $sector) % 26 + ord('a'));
			}
		}

		$name=join('', @name);
		print "FOUND: $name in sector $sector\n" if $name =~ /north/;
	}
}

