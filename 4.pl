#!/bin/perl

while(<>) {
	/(.+)-(\d+)\[(.+)\]/;
	($name, $sector, $chk) = ($1, $2, $3);

	%count = ();
	foreach $letter (split //, $name) {
		next if $letter eq '-';
		$count{$letter}++;
	}

	@keys = sort { $count{$b} <=> $count{$a} || $a cmp $b } keys %count;

	if($chk eq join('', @keys[0..4])) {
		$count++;
		$sum += $sector;
	}
	
	print "count=$count\tsum=$sum\tname=$1  sector=$2   chk=$3  keys=", join(' ', @keys), "\n";
}
