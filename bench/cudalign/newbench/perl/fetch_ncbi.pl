#!/usr/bin/perl
use LWP::Simple;

if (@ARGV != 1 && @ARGV != 2) {
	die ("usage: $0 NCBI_ID [Output directory]\n");
}

if (@ARGV == 2) {
	$dir = $ARGV[1];
} else {
	$dir = ".";
}

$db = 'nucleotide';
$id = $ARGV[0];
$base = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils";

$url = $base . "/efetch.cgi?db=$db&id=$id&rettype=fasta&retmode=text";
print "$url\n";
#post the efetch URL
$data = get($url);

#$id =~ tr/_//d;
($file_name) = $data =~ /^.*?\|.*?\|.*?\|(.*?)\|/;
print "$file_name\n";
#$file_name = "$id";
open FILE,">$dir/$file_name.fasta";
print FILE "$data";
close FILE;
