#!/bin/env perl

use strict;
use warnings;

my $data_dir = './data';
#
my @DT = '';
#
my @alpha = ('a'..'z');
#
my @num = ('0'..'9');
#
my %i = ( domains_url => "http://192.168.1.237:8001/d/domains/domains.txt", domains => '');
#
my %o = (out => '', error => '', warn => '');
#
my %dom;

# 
my @dom = '';
@dom = `wget --tries 1 -O - "$i{domains_url}" 2>/dev/null`; 
#
if ( scalar @dom > 0 ) {
	$o{warn} .= qq{Total dom: } . scalar @dom . qq{0 $dom[0]\n};
} else {
	$o{warn} .= qq{wget error $@ \n};
}

#
foreach my $dm (@dom) {
	
	if ( $dm ) {

		chomp $dm;
		
		$dm =~ s!^\s+$!!g;

		my ($alp_num, $domain) = split(/\=/, $dm, 2);
	
		$dom{"an${alp_num}"} = "$domain";  ## had dm instead of alp_num here. Took, literally hours to figure this out!!!!!!!!!

=head2 Test Output: To a text file

		#`echo $dm >> ./data/domains.txt`;

=cut

	} else {
		$o{error} .= qq{DM Error 45\n};
	}
}

$o{out} .= qq{DOM Hash: 5 $dom[5]\n$dom{"a"}\n$dom{"0"}\n};

if ( -d "$data_dir" ) {
	#
	if ( opendir( my $DT, "$data_dir" ) ) {
		@DT = readdir($DT);
		close $DT;
	} else {
		$o{error} = qq{Unable to open data_dir\n};
	}
	#
} else {
	`mkdir "$data_dir"`;
}

for (@DT) { next unless -f "$data_dir/$_" and $_ =~ /[a-z0-9A-Z]/; $i{total}++ if $_; }
my $total = scalar @DT;
$o{out} .= qq{$total|$i{total}\n};

#

for my $alpha_num ('a'..'z', '0'..'9') {
	#
	chomp $alpha_num;
	#
	if ( -f "$data_dir/$alpha_num.txt" ) {

		#
		$o{warn} .= qq{$alpha_num };

=head2 Test: Delete and Create Again and Again

		#
		`unlink "$data_dir/$alpha_num.txt"`;

		#
		if ( open (my $FILE, ">", "$data_dir/$alpha_num.txt") ) {
			print $FILE qq{//$dom{"an${alpha_num}"}};
			close $FILE;
		} else {
			$o{error} .= qq{FileErr $alpha_num\n};
		}
		#

=cut

	} else {
		#
		if ( open (my $FILE, ">", "$data_dir/$alpha_num.txt") ) {
			print $FILE qq{https://$dom{"an${alpha_num}"}};
			close $FILE;
		} else {
			$o{error} .= qq{FileErr $alpha_num\n};
		}
		#
	}
}

print qq{$o{out}\n$o{error}\n$o{warn}\n};

`cat "$data_dir/a.txt"`;

1;

