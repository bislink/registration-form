#!/usr/bin/env perl

use strict;
use warnings;

# THROUGH WHICH TYPE OF NETWORK IS THE LAPTOP CONNECTED TO THE INTERNET?
    
    # List of URLs to check 
        # laptop is sometimes connected via WiFi or USB C Ethernet
        # so list both possible IPs. 
    my %url = (
        db => '',
        wifi => '192.168.1.237',
        ether => '192.168.1.237',
    );

    # ping each url into an array 
    my @ping1 = `ping -c 1 -4 $url{wifi}`;
    my @ping2 = `ping -c 1 -4 $url{ether}`;

    # check line 5 to see if it had 0% packet loss
        # if so, assign it to $url{db}
    if    ( $ping1[4] =~ /0\% packet loss/ ) { $url{db} = $url{wifi};  } 
    elsif ( $ping2[4] =~ /0\% packet loss/ ) { $url{db} = $url{ether}; }
    else                                     { $url{db} = 'localhost'; }

print qq{$url{db}};