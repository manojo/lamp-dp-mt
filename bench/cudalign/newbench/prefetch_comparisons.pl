#!/usr/bin/perl
use Time::HiRes;
use File::Path qw(make_path);

require "perl/directories.pl";

create_directories();

opendir(DIR, $COMPARISON_PATH);
@files = readdir(DIR);
closedir(DIR);

foreach $file (@files) {
	if ($file eq "." || $file eq "..") {
		next;
	}
	prefetch_comparison("$COMPARISON_PATH/$file");
} 

