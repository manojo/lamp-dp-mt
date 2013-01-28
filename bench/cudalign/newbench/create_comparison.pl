#!/usr/bin/perl

require "perl/directories.pl";

if (@ARGV != 3) {
	die ("usage: $0 NAME NCBI_ID#1 NCBI_ID#2\n");
}

create_directories();

$name = $ARGV[0];
$id0 = $ARGV[1];
$id1 = $ARGV[2];

verify_sequence($id0);
verify_sequence($id1);

$file_name = get_comparison_file($name);

open FILE,">$file_name";
print FILE "$id0\n";
print FILE "$id1\n";
close FILE;



