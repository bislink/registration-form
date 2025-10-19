package registrationform;

# ABSTRACT: Create Mojo App

use Mojo::Base 'Mojolicious', -signatures;

use DBIx::Class;
use registrationform::Database;
use registrationform::Users;
use registrationform::Schema;
use registrationform::Languages;

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  #$r->get('/')->to('Home#welcome');

  $r->get('/_powered_by')->to('Home#_powered_by');

  $r->get('/s/*_id')->to('Shorturl#welcome');

  $self->helper (db => sub { state $db = registrationform::Database->new } );

  # users
  $self->helper ( users => sub { state $users = registrationform::Users->new() } );

  # config
  $self->helper ( conf => sub { state $conf = $self->plugin('NotYAMLConfig') } );

  $r->any('/')->to('home#welcome')->name('welcome');
  $r->get('/login')->to('home#welcome')->name('welcome');
  $r->post('/admin')->to('admin#dash');
  $r->any('/admin')->to('admin#dash');
  my $logged_in = $r->under('/admin')->to('home#logged_in');
  $logged_in->get('/dash')->to('admin#dash');
  # logout
  $r->get('logout')->to('home#logout');

  # Directory Browser 
    # /admin/dir
  $logged_in->get('/dir')->to('admin#_dir');
  # File 
    # /admin/file 
  $logged_in->get('/file')->to('admin#_file');

  $logged_in->get('/shorturl')->to('shorturl#_admin');

  $logged_in->get('/shorturl/_edit/*file')->to('shorturl#_edit');

  $logged_in->post('/shorturl/_save')->to('shorturl#_save');

  $logged_in->get('/shorturl/_add')->to('shorturl#_add');

  $logged_in->post('/shorturl/_added')->to('shorturl#_added');

  $r->get('/_form')->to('Home#_form');
  
}

1;
