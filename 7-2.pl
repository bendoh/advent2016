#!/bin/perl


while(<>) {
	chomp;

	$str = $_;

	$is_aba = '';
	$aba = $bab = $hnets = '';

	while($str =~ s/\[(.+?)]/ /) {
		$hnets .= "$1 ";
	}

	for($i = 0; $i < length($str) - 1; $i++) {
		$a = substr($str, $i, 1);
		$b = substr($str, $i + 1, 1);

		$aba = "$a$b$a";

		next if $aba =~ /[ \[\]]/;
		
		if($a ne $b && $str =~ /$aba/) {
			$bab = "$b$a$b";

			if($hnets =~ /$bab/) {
				$is_aba = "$aba\[$bab\]";
				last;
			}
		}
	}

	if ($is_aba) {
		print "$is_aba | $str [$hnets]\n";
		$ssl++;
	}
}
print "SSL: $ssl\n";
