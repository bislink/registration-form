package registrationform::Home;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub welcome ($self) {

  # Render template "home/welcome.html.ep" with message
  $self->render(msg => 'Welcome to registrationform!');
}

1;
