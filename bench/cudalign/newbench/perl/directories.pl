use File::Path qw(make_path);

$SEQUENCES_PATH = './sequences';
$COMPARISON_PATH = './comparisons';
$WORK_PATH = './work';
$OUTPUT_PATH = './output';
$FETCH_UTILITY = './perl/fetch_ncbi.pl';
$CUDALIGN = '../cudalign';

sub get_sequence_file {
	($id) = @_;
	return "$SEQUENCES_PATH/$id.fasta";
}

sub get_comparison_file {
	($id) = @_;
	return "$COMPARISON_PATH/$id.cmp";
}

sub get_work_dir {
	($id) = @_;
	return "$WORK_PATH/$id";
}

sub get_output_dir {
	($id) = @_;
	$ts = get_timestamp();
	return "$OUTPUT_PATH/$id.$ts";
}

sub get_timestamp {
	if ($timestamp eq "") {
		($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
			= localtime(time);
		$timestamp = sprintf "%4d%02d%02d.%02d%02d%02d", 
			$year+1900,$mon+1,$mday,$hour,$min,$sec;
	}
	return $timestamp;
}

sub get_stderr_file {
	($id) = @_;
	$out_dir = get_output_dir($id);
	return "$out_dir/stderr.txt";
}

sub get_stdout_file {
	($id) = @_;
	$out_dir = get_output_dir($id);
	return "$out_dir/stdout.txt";
}

sub verify_sequence {
	($id) = @_;
	$file = get_sequence_file($id);
	if (-e $file) {
		print "Sequence $id: [  OK  ]\n";
	} else {
		print "File does not exists ($file)\n";
		print "Fetching from NCBI: $id ...\n";
		$out = `$FETCH_UTILITY $id $SEQUENCES_PATH`;
		if (!-e $file) {
			printf "$out\n";
			die("File could not be fetched ($file)\n")
		}
	}
	return $file;
}

sub create_directories {
	make_path (
		$OUTPUT_PATH, 
		$WORK_PATH, 
		$SEQUENCES_PATH, 
		$COMPARISONS_PATH
	);
}

sub prefetch_comparison {
	my ($file_name) = @_;

	open FILE, "$file_name" or die ("Error opening file $file_name: $!");
	my $id0 = <FILE>;
	chomp($id0);
	my $id1 = <FILE>;
	chomp($id1);
	my $args = "";
	while ($line = <FILE>) {
		chomp($line);
		$args .= " $line";
	}
	close FILE;

	my $file0 = verify_sequence($id0);
	my $file1 = verify_sequence($id1);

	return ($file0, $file1, $args);
}
