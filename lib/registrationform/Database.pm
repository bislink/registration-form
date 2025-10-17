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

=cut

    my $dir = '';
    $dir = "/home/$user/m/mojoapp/";
        chomp $dir;
    #
    my $db_url = `$dir/get_database_url.pl`;
    chomp $db_url;

    my %i = (
        dsn => "dbi:mysql:example2home:$db_url:3308",
        user => 'example2home',
        pass => '8RJ7RLIalEucfIk'
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
