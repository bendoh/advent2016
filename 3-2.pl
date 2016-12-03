#!/bin/perl

# --- Part Two ---
# 
# Now that you've helpfully marked up their design documents, it occurs to you that triangles are specified in groups of three vertically. Each set of three numbers in a column specifies a triangle. Rows are unrelated.
# 
# For example, given the following specification, numbers with the same hundreds digit would be part of the same triangle:
# 
# 101 301 501
# 102 302 502
# 103 303 503
# 201 401 601
# 202 402 602
# 203 403 603
# In your puzzle input, and instead reading by columns, how many of the listed triangles are possible?

@triangles = ([], [], []);
$triangles = 0;
$lines = 0;

while(<>) {
	/(\d+)\s*(\d+)\s*(\d+)/;

	push @{$triangles[0]}, $1;
	push @{$triangles[1]}, $2;
	push @{$triangles[2]}, $3;
	$lines++;

	if($lines % 3 == 0) {
		foreach $triangle (@triangles) {
			($a, $b, $c) = @$triangle;
			print join("\t",$a+$b,$c,$b+$c,$a,$a+$c,$b);
			$triangles++ if $a + $b > $c && $b + $c > $a && $a + $c > $b;
			print "\t$triangles\n";
		}

		@triangles = ([], [], []);
	}
}

print "Triangles: $triangles, Lines: $lines\n";
