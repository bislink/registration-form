package registrationform::Database;

# ABSTRACT: Database, Create Mojo App

use Mojo::Base 'Mojolicious::Controller', -signatures;

=head2 Get USER from pwd
=cut

sub get_user_from_pwd {

    my $user = '';
    
    my $pwd = `pwd`;
    chomp $pwd;

    my @pwd = split(/\//, $pwd);
    
    if ( $pwd =~ /^\/root/ ) { $user = $pwd[1]; }
    elsif ( $pwd =~ /^\/home/ ) { $user = $pwd[2]; }

    return $user;

}


=head2 DB Config

=cut

sub db_config ($c) {

    my $user = get_user_from_pwd;

=head2 Get DB URL
    
    Only for/on HP Envy Laptop 17-ch0xxx

    MySQL 8.0.40 ()

    The file, get_database_url.pl, in /m/mojoapp is the stable provider 
        for all apps on this device only. 

=cut

    my $dir = '';
    $dir = $c->conf->{thisapp}->{dir}->{main};
        chomp $dir;
    #
    my $db_url = $c->conf->{thisapp}->{database}->{url};
    chomp $db_url;

    my $db_name = $c->conf->{thisapp}->{database}->{name};
    chomp $db_name;

    my $db_user = $c->conf->{thisapp}->{database}->{user};
    chomp $db_user;
    
    my $db_pass = $c->conf->{thisapp}->{database}->{pass};
    chomp $db_pass;

    my %i = (
        dsn => "dbi:mysql:$db_name:$db_url:3308",
        user => "$db_user",
        pass => "$db_pass"
    );

    return %i;
}

sub dbi_params ($c) {

    my %i = (
        RaiseError        => 1,
        mysql_enable_utf8 => 1,
        auto_reconnect => 1
    );

    return %i;
}


1;
