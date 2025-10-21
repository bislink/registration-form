package Createform::Users;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::Util qw(secure_compare);

use Createform::Schema; 
use Createform::Database;

use Digest::MD5 qw(md5 md5_hex md5_base64);

sub new { bless {}, shift }

sub check ($c, $user, $pass) {

    # Connect to database
    my %db = Createform::Database->db_config();
    my %dbi_params = Createform::Database->dbi_params();
    # retrieve data
    my $row = '';
    my $schema = Createform::Schema->connect($db{dsn}, $db{user}, $db{pass}, \%dbi_params);
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

    chomp $r{pass};
    $r{md5_of_pass} = md5_hex($pass);

    # Success
    #return 1 if $pass && secure_compare $pass, $r{pass};
    return 1 if ($user eq $r{username}) and ($r{md5_of_pass} eq $r{pass});
    # Fail
    return undef;


}

1;
