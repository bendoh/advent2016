#!/bin/perl
#

my %count = ();
while(<>) {
	@letters = split //;

	for($i = 0; $i < @letters; $i++) {
		$count{$i}{$letters[$i]}++;
	}
}

$code = '';

for($i = 0; $i < keys %count; $i++) {
	$code .= (sort { $count{$i}{$a} <=> $count{$i}{$b} } keys %{$count{$i}})[0];
}

print "$code\n";
