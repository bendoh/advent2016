#!/bin/perl


while(<>) {
	chomp;

	$str = $_;

	$is_abba = 0;
	for($i = 0; $i < length($str) - 1; $i++) {
		$a = substr($str, $i, 1);
		$b = substr($str, $i + 1, 1);

		$in_subnet = 1 if $b eq '[';
		$in_subnet = 0 if $a eq ']';

		$abba = "$a$b$b$a";

		if($a ne $b && substr($str, $i, 4) eq $abba) {
			$is_abba = $abba;

			if($in_subnet) {
				print "($abba) REJECTED in subnet\n";
				$is_abba = '';
				last;
			}

			print "($abba) | $str\n";
		}
	}

	if ($is_abba) {
		print "$is_abba | $str\n";
		$abbas++;
	}
}
print "Abbas: $abbas\n";
