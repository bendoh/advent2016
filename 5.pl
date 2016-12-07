#!/bin/perl

#
#--- Day 4: The Ideal Stocking Stuffer ---

# Santa needs help mining some AdventCoins (very similar to bitcoins) to use as gifts for all the economically forward-thinking little girls and boys.
# 
# To do this, he needs to find MD5 hashes which, in hexadecimal, start with at least five zeroes. The input to the MD5 hash is some secret key (your puzzle input, given below) followed by a number in decimal. To mine AdventCoins, you must find Santa the lowest positive number (no leading zeroes: 1, 2, 3, ...) that produces such a hash.
# 
# For example:
# 
# If your secret key is abcdef, the answer is 609043, because the MD5 hash of abcdef609043 starts with five zeroes (000001dbbfa...), and it is the lowest such number to do so.
# If your secret key is pqrstuv, the lowest number it combines with to make an MD5 hash starting with five zeroes is 1048970; that is, the MD5 hash of pqrstuv1048970 looks like 000006136ef....

use Digest::MD5 'md5_hex';
$doorid=<>;chomp $doorid;

@password = ();

print "Mining $doorid...\n";

$j = 0;

while(1) {
	do {
		$hash = md5_hex($doorid . $i++);
		$pos = substr($hash, 5, 1);
		$chr = substr($hash, 6, 1);
	} while(substr($hash, 0, 5) ne '00000');

	next if hex $pos > 7;

	if($password[$pos] eq '') {
		$password[$pos] = $chr;
		$j++;
		print join('', map {$_ eq '' ? '_' : $_} @password[0..7]) . "\n";
	}

	last if $j == 8;
}

