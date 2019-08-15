#!/usr/bin/perl -w 
#

=head1 NAME

fix_file_names.pl - fix filenames in data hierarchy

=head1 SYNOPSIS

    fix_file_names.pl --debug --file FILE

    --help, --?         print help message

=head1 DESCRIPTION

This is completely ad hoc.  Trying to get a directory fixed up to archive it.  

=head1 KNOWN ISSUES

=head1 AUTHOR

Arlin Stoltzfus (arlin@umd.edu)

=cut

use strict; 
use Getopt::Long; 
use Data::Dumper; 
use Pod::Usage; 

# process command-line arguments 
#

my ( $help ); 
my $debug = 0; 

my $outfile = "change_log.txt";
GetOptions(
    "file=s" => \$outfile, 
    "debug!" => \$debug, 
    "help|?" => \$help
    ) or pod2usage( "Invalid command-line options." );
pod2usage() if defined( $help ); 

my $script = $0; 
$script =~ s#^.*/##; 

# let's open a file for notes  
open(my $fh, ">", $outfile ) or die "cannot open > $outfile: $!";

# get the list of sub-directories 

my %shape_rename = (
#	"8tax_int" => "int", 
#	"8tax_pec" => "pec", 
	"8tax_sym" => "sym" ); 

my $start_dir = `pwd`; 
foreach my $dir (keys( %shape_rename ) )  { 
 	my $newdir = $shape_rename{ "$dir" };
	chdir $newdir or die "Cannot chroot to $newdir: $!\n";
	for ( my $i = 6; $i <= 100; $i++ ) { 
		my $subdir = $newdir."_".$i; 
		chdir $subdir or die "Cannot chroot to $subdir: $!\n";
		my $command = sprintf( "for f in *%s*.tre; do git mv \$f `echo \$f | sed 's/^%s/%s_%s_/'`; done", $i, $i, $newdir, $i ); 
		printf( STDERR "running $command in $newdir/$subdir\n" ); 
		system( $command ) unless $debug; 

# 		foreach my $density ( "4", "10", "25" ) { 
# 			my $sub_subdir = "f".$density; 
# 			chdir $sub_subdir or die "Cannot chroot to $sub_subdir: $!\n";
# 			# flank $sub_subdir with underscores
# 			my $command = sprintf( "for f in z%s*; do mv \$f `echo \$f | sed 's/^z/z_/'`; done", $newdir ); 
# 			printf( STDERR "running $command in $newdir/$subdir/$sub_subdir\n" ); 
#  			system( $command ) unless $debug; 
# 			$command = sprintf( "for f in *_\\.*; do mv \$f `echo \$f | sed 's/_\\././'`; done" ); 
# 6			printf( STDERR "running $command in $newdir/$subdir/$sub_subdir\n" ); 
# 			system( $command ) unless $debug; 
# 			$command = sprintf( "for f in *obs*; do mv \$f `echo \$f | sed 's/[_\.]obs/_obs_/'`; done" ); 
# 			printf( STDERR "running $command in $newdir/$subdir/$sub_subdir\n" ); 
# 			system( $command ) unless $debug; 
# 			$command = sprintf( "for f in *marsh*; do mv \$f `echo \$f | sed 's/[_\.]marsh/_m08_/'`; done" ); 
# 			printf( STDERR "running $command in $newdir/$subdir/$sub_subdir\n" ); 
# 			system( $command ) unless $debug; 
# 			$command = sprintf( "for f in *m2arsh*; do mv \$f `echo \$f | sed 's/[_\.]m2arsh/_m08min_/'`; done" ); 
# 			printf( STDERR "running $command in $newdir/$subdir/$sub_subdir\n" ); 
# 			system( $command ) unless $debug; 
# 			$command = sprintf( "for f in *[_\.]p*; do mv \$f `echo \$f | sed 's/[_\.]p/_peng_/'`; done" ); 
# 			printf( STDERR "running $command in $newdir/$subdir/$sub_subdir\n" ); 
# 			system( $command ) unless $debug; 
# 			$command = sprintf( "for f in *hfd*; do mv \$f `echo \$f | sed 's/[_\.]hfd/_glin_/'`; done" ); 
#
# 5			my $command = sprintf( "for f in *%s[sip]_*.tre; do mv \$f `echo \$f | sed 's/%s[psi]_/%s_%s_/'`; done", $i, $i, $newdir, $i ); 
#
# 4			my $command = sprintf( "for f in *%s*.tre; do mv \$f `echo \$f | sed 's/$sub_subdir/_%s_/'`; done", $sub_subdir, $sub_subdir ); 
#
# 3			my $command = sprintf( "for f in *_%s[^_]*; do mv \$f `echo \$f | sed 's/%i_%s\\.*/%i_f%s./'`; done", $density, $i, $density, $i, $density ); 
# 			printf( STDERR "running $command in $newdir/$subdir/$sub_subdir\n" ); 
# 			system( $command ) unless $debug; 
# 			chdir ".." or die "cannot chroot up from $sub_subdir";
#		}
		chdir ".." or die "cannot chroot up from $subdir"; 
	}
	chdir ".." or die "Cannot chroot to $start_dir: $!\n";
}

exit; 
