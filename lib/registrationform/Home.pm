package registrationform::Home;

# ABSTRACT: Home, Create Mojo App

use Mojo::Base 'Mojolicious::Controller', -signatures;

sub welcome ($self) {

    my $user = $self->param('user') || '';
    my $pass = $self->param('pass') || '';
    #
    if ( $self->session('user') ) {
        $self->render('/admin/dash');
    } else {
        return $self->render unless $self->users->check($user, $pass);
        $self->session(user => $user);
        $self->flash(message => 'Thanks for logging in.');
        $self->redirect_to('/');
    }
}

sub logged_in ($self) {
    return 1 if $self->session('user');
    $self->render('/admin/dash');
    return undef;
}

sub logout ($self) {
    $self->session(expires => 1);
    $self->redirect_to('/');
}


sub _powered_by ($c) {
    my $HOME = $c->conf->{thisapp}->{dir}->{main};
  $c->render( out => " ");
}

sub _form ($c) {
    my $out = ' ';
    my $HOME = $c->conf->{thisapp}->{dir}->{main};
    my $PUB = 'public/assets';
    my $FILE_NAME = 'form-elements.txt';
    my $FILE =  "$HOME/$PUB/$FILE_NAME";
    my $FH;
    if ( -f "$FILE") {
        #$out .= "<h3>$FILE_NAME is accessible</h3>";
        if ( open ($FH, "<", "$FILE") ) {
            while (my $LINE = <$FH>) {
                my $EXPANDED = $LINE; 
                $EXPANDED =~ s!\_! !g; 
                $EXPANDED = uc($EXPANDED);
                $out .= qq{<div class="mb-3">};
                $out .= qq{<label for="$LINE" class="form-label">$EXPANDED</label>};
                $out .= qq{<input name="$LINE" id="$LINE" class="form-control form-control-lg" type="text" placeholder="$LINE"};
                $out .= qq{ aria-label="$EXPANDED">};
                $out .= qq{</div>};
            }
            close $FH;
        }
    } else {
        $out .= qq{ Unable to open '$FILE_NAME'};
    }
    
    $c->render( out => $out );
}




1;
