#!/usr/bin/perl -w

use strict;
#contig_length_fasta.pl
my $largest = 0;

my $contig = '';

if (@ARGV != 1) {
        print "contig_length_fastq fasta\n\n" ;
        exit ;
}

my $filenameA = $ARGV[0];

open (IN, "$filenameA") or die "oops!\n" ;
        
        my $read_name = '' ;
        my $read_seq = '' ;

        print "##gff-version 3\n" ;
        while (<IN>) {
            if (/^>(\S+)/) {
                $read_name = $1 ;
                $read_seq = "" ;

                while (<IN>) {

                        if (/^>(\S+)/) {

                            print "##sequence-region " . "$read_name " . "1 " . length($read_seq) . "\n" ;

                            $read_name = $1 ;
                            $read_seq = "" ;

                        }

                        else {
                            chomp ;
                            $read_seq .= $_ ;
                        }

                }

            }
        }

close(IN) ;

print "##sequence-region " . "$read_name " . "1 " . length($read_seq) . "\n" ;
