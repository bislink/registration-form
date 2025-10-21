package Createform::Database;

# ABSTRACT: Database, Create Mojo App

use Mojo::Base 'Mojolicious::Controller', -signatures;

=head2 Database Credentials File

    Get base/home path/dir from pwd

    Remove lib/Sumu from pwd to get the home dir

    Set name for credentials file: 
        - hardcoded into this file
        - located in app home directory
        - not added to git

=cut

my $pwd = `pwd`; 
chomp $pwd;

my $home_dir = "$pwd";
$home_dir =~ s!\/lib/Sumu!!;

my %db = (
        home_dir => "$home_dir",
        db_creds_file => "database_credentials.txt"
    );

=head2 DB Config

    DB Configurations
        - Extracted from cred file located in app home.

=cut

sub db_config ($c) {

=head2 ERROR 

=head3 This is what causes the infamous error: 'cannot use App::Database as string....''

    %db =( 
        host_or_ip => $c->conf->{thisapp}->{database}->{host_or_ip},
        port => $c->conf->{thisapp}->{database}->{port},
        name => $c->conf->{thisapp}->{database}->{name},
        user => $c->conf->{thisapp}->{database}->{user},
        pass => $c->conf->{thisapp}->{database}->{pass}
    );

=cut

=head2 So, instead, get the credentials from a file

=cut

    ##$db{home_dir} = $c->conf->{thisapp}->{dir}->{home};
    

    if (open( my $FILE, "<", "$db{home_dir}/$db{db_creds_file}") ) {
        while ( my $line = <$FILE> ) {
            chomp $line;
            my ($left, $right) = split(/\|/, $line, 2);
            $db{"$left"} = "$right";
        }
        close $FILE;
    } else {
        $db{error} .= qq{Could not find file};
    }

    my %i = (
        dsn => "dbi:$db{driver}:$db{name}:$db{host_or_ip}:$db{port}",
        user => "$db{user}",
        pass => "$db{pass}",
        @_,
    );

    return %i;
}

sub dbi_params {

    my %i = (
        RaiseError        => 1,
        mysql_enable_utf8 => 1,
        auto_reconnect => 1,
        @_,
    );

    return %i;
}


=head3 Create Table and First User SQL

=head4 2022-09-22-0952

create table users ( \
    id bigint primary key auto_increment not null, \
    username varchar(50), \
    userpass varchar(99), \
    created timestamp default current_timestamp on update current_timestamp \
);
insert into users ( username, userpass ) values ('ns50pi', 'empyocbirphajupt');

=cut

1;

