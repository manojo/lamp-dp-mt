#!/usr/bin/perl

#for ($i=27; $i<=512; $i++) {
for ($i=286; $i<=512; $i++) {
	$b = $i;
	$exe = "rm -r work/; time ./run_comparison.pl 1M 1n"
		. " --blocks=$b";
	print $exe;
	print `$exe`;
}
