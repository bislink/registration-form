use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use Mojo::File qw(curfile);
use lib curfile->dirname->sibling('lib')->to_string;

my $t = Test::Mojo->new('registrationform');
$t->get_ok('/')->status_is(200)->content_like(qr/registrationform/i);


$t->post_ok('/admin' => form => { user => 'e2h', pass => '8RJ7RLIalEucfIk' } )
    ->status_is(302)
;

done_testing();
