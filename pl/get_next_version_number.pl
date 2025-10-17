#!/usr/bin/perl

use strict;
use warnings;

my $pwd = `pwd`;
chomp $pwd;

my $next_commit_id = `$pwd/pl/get_commit_id.pl`;
chomp $next_commit_id;

#
print convert_2_version();

=head1 NAME
    Convert NNN to N.N.N
=head2 DESC
=cut

sub convert_2_version {
    my @val = split(//, $next_commit_id);
    my $out;
    for (@val) {
        $out .= qq{$_.};
    }
    #
    $out =~ s!\.$!!;
    #
    return $out;
}

1;

