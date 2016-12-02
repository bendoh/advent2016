#!/bin/perl

use List::Util qw(min);

# Pass input as a comma-separated list on stdin
@input = split ',', <>;

# North at 0, east 1, south 2, west 3
$dir = 0;
$dist_ns = 0;
$dist_ew = 0;

%locations = ();

$first_visited_twice = 0;

print "Input Length: " . @input . " entries.\n";
print "START ($dir)  $dist_ns N, $dist_ew E: Total: " . (abs($dist_ns) + abs($dist_ew)) . "\n";

for($i = 0; $i < @input; $i++) {
	$step = $input[$i];

	$step =~ /([RL])(\d+)/ or die "Invalid input #$i: $step ";

	$turn = $1;

	if($turn eq 'R') {
		$dir++;
	}
	elsif($turn eq 'L') {
		$dir--;
	}

	$dist = $2;
	$dir = $dir % 4;
	$sign = 1;
	$dim = \$dist_ns;

	if($dir > 1) {
		$sign = -1;
	}
	if($dir == 1 || $dir == 3) {
		$dim = \$dist_ew;
	}

	for($j = 0; $j < $dist; $j++) {
		$$dim += $sign;

		if($locations{"$dist_ns:$dist_ew"} && !$first_visited_twice) {
			print "I've passed through $dist_ns:$dist_ew before!\n";
			$first_visited_twice = [ $dist_ns, $dist_ew, $step ];
		}

		$locations{"$dist_ns:$dist_ew"} = 1;
	}

	print "$i $turn ($dir+$dist) $dist_ns N, $dist_ew E, Distance: " . (abs($dist_ns) + abs($dist_ew)) . "\n";
}

print "$dist_ns N, $dist_ew E: Total: " . (abs($dist_ns) + abs($dist_ew)) . "\n";
print "First visited twice: $first_visited_twice->[0] N, $first_visited_twice->[1] E, Distance: " . (abs($first_visited_twice->[0]) + abs($first_visited_twice->[1])) . "\n";
