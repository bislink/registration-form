#!/usr/bin/perl

use strict;
use warnings;

# random small letter 
my @alpha = ('a'..'z');
my $small_letter = "" . $alpha[int(rand(@alpha))] . "";

my $OUT;
my @CONT = `apg -n 19 -m 120`;
foreach my $line (@CONT) {
    
    # replace metachar with a small letter
    $line =~ s!(\`|\!\@|\$|\%|\^|\&|\*|\(|\)|\-|\_|\=|\+|\[|\]|\{|\}|\;|\:|\'|\"|\,|\.|\<|\>|\/|\?|\|\!|\~)!$small_letter!g; 

    # replace caps with small 
    #$line =~ s!\u!!g; 

    $OUT .= qq{  - $line};
}

# argv0 contains the file extension
my $YAML_FILE = "$ARGV[0]";

sub append_to_yaml_file {

    my $file_name = shift;

    my $out;

    if (-f "$file_name") {
        if ( open my $FILE, ">>", "$file_name" ) {
            print $FILE qq{$OUT};
            close $FILE;
        } else {
            print qq{Err#14\n};
        }
    } else {
        print "Unable to open file $file_name\n";
    }
}

&append_to_yaml_file("$YAML_FILE");


1;
