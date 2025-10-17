package registrationform::Schema::Result::Users;
use base qw( DBIx::Class::Core );
use strict;
use warnings;

__PACKAGE__->table('users');

__PACKAGE__->add_columns(
    id => {
        data_type => 'bigint',
        is_auto_increment => 1,
        size => 32,
        is_nullable => 0
    },
    username => {
        data_dype => 'varchar',
        size      => 50,
        is_nullable => 0
    },
    userpass => {
        data_type => 'varchar',
        size      => 99,
        is_nullable => 0
    },
    created => {
        data_type => 'timestamp',
        is_nullable => 1
    }
);
#
__PACKAGE__->set_primary_key('id');
#
1;
