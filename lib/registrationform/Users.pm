package registrationform::Users;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::Util qw(secure_compare);

use registrationform::Database;
use registrationform::Schema; 

sub new { bless {}, shift }

sub check ($c, $user, $pass) {

    # Connect to database
    my %db = registrationform::Database->db_config();
    my %dbi_params = registrationform::Database->dbi_params();
    # retrieve data
    my $row = '';
    my $schema = registrationform::Schema->connect($db{dsn}, $db{user}, $db{pass}, \%dbi_params);
    #
    my %r;
    if ( $user ne '' ) {
        $row = $schema->resultset('Users')->search( username => "$user" );
        for my $r ($row->first) {
            $r{username} = $r->username;
            $r{pass} = $r->userpass;
            $r{id} = $r->id;
        }
    }

    # Success
    return 1 if $pass && secure_compare $pass, $r{pass};
    # Fail
    return undef;


}

1;
