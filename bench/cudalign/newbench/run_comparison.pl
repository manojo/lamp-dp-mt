#!/usr/bin/perl
use Time::HiRes;
use File::Path qw(make_path);

require "perl/directories.pl";

if (@ARGV < 2) {
	die ("usage: $0 COMPARISON STAGE [ARGS]\n");
}

create_directories();

($cmp, $stage, @other_args) = @ARGV;
$final_args = "";
foreach my $arg (@other_args) {
	$final_args .= " $arg";
}
print "$final_args\n";

$file_name = get_comparison_file($cmp);

if (!-e $file_name) {
	die ("Comparison $file_name not exists. Use create_comparison.pl script.");
}

($file0, $file1, $args) = prefetch_comparison($file_name);

$work_dir = get_work_dir($cmp);
$output_dir = get_output_dir($cmp);
$stderr_file = get_stderr_file($cmp);
$stdout_file = get_stdout_file($cmp);

make_path ($work_dir, $output_dir);

%stages_args = (
	'all' => '',
	'1' => '--stage-1 --clear',
	'1n' => '--stage-1 --no-flush --clear',
	'2' => '--stage-2',
	'3' => '--stage-3',
	'4' => '--stage-4',
	'4n' => '--stage-4 --not-orthogonal',
	'5' => '--stage-5',
);

if (defined $stages_args{$stage}) {
	$stage_args = $stages_args{$stage};
} else {
	die ("unknown stage name: $stage");
}


$exe = "$CUDALIGN --work-dir=$work_dir $args $stage_args $final_args $file0 $file1";

print "$exe...\n\n";
$t0 = Time::HiRes::gettimeofday();
#`((($exe > $stdout_file) 3>&1 1>&2 2>&3 | tee $stderr_file) 3>&1 1>&2 2>&3)`;
#`$exe 1>$stdout_file 2>$stderr_file`;

open EXE, "($exe > $stdout_file) 3>&1 1>&2 2>&3 |" or die;
open (LOGFILE, ">$stdout_file") or die;
while (<EXE>) { print LOGFILE $_; print }
close EXE; # to get $?
my $return_code = $?;


#$return_code = $?;
$t1 = Time::HiRes::gettimeofday();
$totalTime= ($t1-$t0)*1000;

print "rc: $return_code\n";

if ($return_code != 0) {
	print "CUDAlign exited with error code: $return_code\n";
	exit $return_code;
}

open FILE, "$work_dir/statistics_01";
$stat = join "",<FILE>;
close FILE;

($time) = $stat =~ /total:\s+(\S+)\s/;
($score) = $stat =~ /Best Score:\s+(\S+)\s/;
($pos) = $stat =~ /Best Position:\s+(\S+)\s/;
($name1, $size1, $name2, $size2) 
    = $stat =~ /Alignment sequences:.*?>(.*?)\s*\((\d+)\).*?>(.*?)\s*\((\d+)\)/s;

$str = <<END;
#NAME_1: $name1
#SIZE_1: $size1
#NAME_2: $name2
#SIZE_2: $size2
#TIME: $time
#SCORE: $score
#POS: $pos
#TOTAL_TIME: $totalTime
END

print $str;

print `cp $work_dir/* $output_dir`;
print `cp $work_dir/midpoints/midpoint_0? $output_dir/midpoints`;

open FILE, ">$output_dir/stat_$cmp.$stage.txt";
print FILE $str;
close FILE;

`ls -l $work_dir/special1 | wc > $output_dir/ls.s1.$stage`;
`ls -l $work_dir/special2 | wc > $output_dir/ls.s2.$stage`;
`du $work_dir > $output_dir/du.$stage`;



$timestamp = get_timestamp();
$targz = "tar/output.$cmp.$stage.$timestamp.tgz";
mkdir "tar";
print `tar -cvzf $targz $output_dir`;

