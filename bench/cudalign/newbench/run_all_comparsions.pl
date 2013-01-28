#!/usr/bin/perl
use Time::HiRes;
use File::Path qw(make_path);

require "perl/directories.pl";

create_directories();

opendir(DIR, $COMPARISON_PATH);
my @files = readdir(DIR);
closedir(DIR);

foreach $file (@files) {
	if ($file eq "." || $file eq ".." || $file !~ /\.cmp$/) {
		next;
	}
	prefetch_comparison("$COMPARISON_PATH/$file");
} 

opendir(DIR, $COMPARISON_PATH);
@files = readdir(DIR);
closedir(DIR);
@files = sort @files;

foreach $file (@files) {
	if ($file eq "." || $file eq ".." || $file !~ /\.cmp$/) {
		next;
	}
	$file =~ /^(.*)\.cmp$/;
	print `./run_comparison.pl $1 all\n`;
} 

