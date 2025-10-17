#!/usr/bin/perl
use strict;
use warnings;
#
my $PORT_FILE;
#
my $CURRENT_USER;
my $PWD = `pwd`;
chomp $PWD;
my @PWD = split(/\//, $PWD);
#
if ( $PWD =~ /^\/root/ ) {
  $CURRENT_USER = "root";
  chomp $CURRENT_USER;
  $PORT_FILE = "/$CURRENT_USER/00_LAST_PORT.txt";
} elsif ( $PWD =~ /^\/home/ ) {
  $CURRENT_USER = "$PWD[2]";
  chomp $CURRENT_USER;
  $PORT_FILE = "/home/$CURRENT_USER/00_LAST_PORT.txt";
}

#
my $CURRENT_PORT;
my $NEXT_PORT;
#
$CURRENT_PORT = open_file("$PORT_FILE");
#
chomp $CURRENT_PORT;
#
$NEXT_PORT = $CURRENT_PORT + 1;
#
print "$NEXT_PORT";

sub open_file {

    my $file_name = shift;

    my $out;

    if (-f "$file_name") {
        if ( open my $file, "<", "$file_name" ) {
            $out = <$file>;
            close $file;
        } else {
            $out = qq{Err#14\n};
        }
        #print qq{$out\n};
    } else {
        $out = "Unable to open file $file_name\n";
    }
    #
    chomp $out;
    return $out;
}

#&open_file('./secrets.txt');
