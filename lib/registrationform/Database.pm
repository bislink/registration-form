package registrationform::Database;

# ABSTRACT: Database, Create Mojo App

=head1 Database

    for registrationform

=head2 Is This File User Editable?

    NO

=cut

use Mojo::Base 'Mojolicious::Controller', -signatures;

=head2 Get USER 

    from pwd

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

=head2 Get User

    Not needed after moving db credentials 

=cut

    my $user = get_user_from_pwd;

=head2 Get DB  
    
    Removed hardcoded DB credentials from this file to .yml

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

    my $db_port = $c->conf->{thisapp}->{database}->{port};
    chomp $db_port;

    my %i = (
        dsn => "dbi:mysql:$db_name:$db_url:$db_port",
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
