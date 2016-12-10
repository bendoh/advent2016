#!/bin/perl
#

$input = <>;
chomp $input;

sub decompsize {
	my $string = shift;
	my $d = "\t" . shift;
	my $size = 0;
	my @lets = split //, $string;
	my $count = '';
	my $repeat = '';
	my $field;
	my $i;

	print "$d string='$string'\n";
	for($i = 0; $i < @lets; $i++) {
		if($lets[$i] eq '(') {
			$count = $repeat = '';
			$field = \$count;

			for($i++; $lets[$i] ne ')'; $i++) {
				if($lets[$i] eq 'x') {
					$i++;
					$field = \$repeat;
				}
				$$field .= $lets[$i];
			}

			$str_to_repeat = join('', @lets[$i+1..($i+$count)]);
			print "$d repeating $str_to_repeat (" . length ($str_to_repeat) . ") $repeat times\n";
			print "$d size=$size i=$i\n";
			$total = decompsize($str_to_repeat, $d);
			$size += $total * $repeat;

			$i += $count;
			print "$d size=$size i=$i\n";
		}
		else {
			print "$d next=$lets[$i]\n";
			$size++;
		}
	}

	return $size;
}

print "length: " . decompsize($input) . "\n";
