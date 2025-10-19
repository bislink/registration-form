package Createform::Shorturl;

# ABSTRACT: Short URL, Create Mojo App

use Mojo::Base 'Mojolicious::Controller', -signatures;

=head2 Sub Welcome

This is where the actual redirection occurs

=cut

sub welcome ($self) {

  my %o;

  my $id = $self->param('_id');
  chomp $id;

  # if param is not empty
  if ( $id ne '' ) {
    # if param is a number or alphanumeric
    if ( $id =~ /\d+/ or $id =~ /[a-zA-Z0-9]/ ) {

      # remove / at the beginning of id
      $id =~ s!^\/!!;

      ##$id =~ s!^\/r\/!!;

      # also remove metachars in ID
      $id =~ s!(\`|\~|\!|\@|\$|\%|\^|\*|\(|\)|\[|\{|\]|\}|\<|\>|\!)!!g;

      if ( open ( my $ID_FILE, "<", "./data/$id.txt") ) {
        my $url = <$ID_FILE>;
        chomp $url;
        close $ID_FILE;

        # Load template and redirect in the template: example/redirect
        $self->render( '/shorturl/redirect', id => "$id", url => "$url", error => "39" );
        #

      } else {

          if ( $id =~ /^admin/ ) {
            $self->render( '/shorturl/redirect', id => "$id", url => "Admin", error => "Er#39 " );
          } else {
            # Template: example/welcome
            $self->render( '/shorturl/redirect', id => "$id", url => "No Such ID", error => "Er#33 " );
          }

      }

    } else {
      # Template: example/welcome
      $self->render( '/shorturl/redirect', id => "", url => "", error => "Er#22 " );
    }
  } else {
    # param is empty. Show main page or login form. Template: example/welcome
    $self->render( '/shorturl/redirect', id => "", url => "", error => "Er#48 No Short URL provided $id" );
  }

}


=head2 ShortURL Admin

    show links to view 
    
        and edit all short urls

    files under ./data 

=cut

sub _admin ($c) {

    my %i = (
        main_dir => $c->conf->{thisapp}->{dir}->{main},

    );

    my %o;

    if ( opendir( my $DATA_DIR, "$i{main_dir}/data" ) ) {

        while (my $FILE = readdir($DATA_DIR) ) {

            if ( -f "$i{main_dir}/data/$FILE" and $FILE =~ /[a-zA-Z0-9]/ ) {
                #
                my ($file_name, $file_ext ) = split(/.txt/, $FILE, 2);

                # get the url in the file 
                my $url; 
                #
                if ( open( my $F, "<", "$i{main_dir}/data/$FILE" ) ) {

                    $url = <$F>;
                    close $F;

                    chomp $url; 

                } else {

                    $url = qq{<div class="alert alert-warning">Unable to open FILE or FILE not found</div>};
                }
                #
                $o{FILES} .= qq{
                    <tr> 
                        <td> <a id="$file_name" href="//localhost:10103/s/$file_name" target="_blank" title="Short">DOM/s/$file_name</a> </td> 
                        <td> <a href="/admin/shorturl/_edit/$FILE" title="Edit $file_name">$file_name</a> </td>
                        <td>$url</td> 
                    </tr>
                };
                #
            } else {
                ##$o{error} = qq{ err86 };
            }
        }

    } else {
        $o{error} = qq{<div class="alert alert-warning">Unable to opne Data Dir $i{data_dir} </div>};
    }

    $c->render(
        '/shorturl/_admin', 
        files => $o{FILES}, 
        error => $o{error},
        dir => "$i{main_dir}/data"
    );

}
# end 


=head2 Shorturl Admin -> Edit

=cut

sub _edit ($c) {

    my %i = (
        main_dir => $c->conf->{thisapp}->{dir}->{main},
        file => $c->param('file'),
    );

    my %o;

    chomp $i{file};

    my ($file_name, $file_ext ) = split(/.txt/, $i{file}, 2);

    if ( open ( my $FILE, "<", "$i{main_dir}/data/$i{file}") ) {
        
        #
        $i{redirect_url} = <$FILE>;

        close $FILE;

        $o{short} = $file_name;

    }

    $c->render(
        '/shorturl/_edit',
        short => $o{short},
        url => $i{redirect_url},
        error => $o{error}
    );

}
#end



=head2 Shorturl Admin -> Save

=cut

sub _save ($c) {

    my %i = (
        main_dir => $c->conf->{thisapp}->{dir}->{main},
        short => $c->param('short'),
        url => $c->param('url'),
    );

    my %o;

    chomp $i{short};

    chomp $i{url};

    if ( $i{short} ne '' and $i{url} ne '' ) {

        if ( open ( my $FILE, ">", "$i{main_dir}/data/$i{short}.txt") ) {
        
            #
            print $FILE qq{$i{url}};

            #
            close $FILE;

        }

    } else {

        $o{error} = qq{<div class="alert alert-danger">Could not save! Error#189</div>};
    }

    

    $c->render(
        '/shorturl/_save',
        short => $o{short},
        url => $i{url},
        error => $o{error}
    );

}
#end


=head2 Sub Add A Short URL

=cut

sub _add ($c) {

    my %o;
    
    $c->render(

        '/shorturl/_add',

    );

}
#end


=head2 Shorturl Admin -> Added

=cut

sub _added ($c) {

    my %i = (
        main_dir => $c->conf->{thisapp}->{dir}->{main},
        short => $c->param('short'),
        url => $c->param('url'),
    );

    my %o;

    chomp $i{short};

    chomp $i{url};

    if ( $i{short} ne '' and $i{url} ne '' ) {

        if ( open ( my $FILE, ">", "$i{main_dir}/data/$i{short}.txt") ) {
        
            #
            print $FILE qq{$i{url}};

            #
            close $FILE;

        }

    } else {

        $o{error} = qq{<div class="alert alert-danger">Could not Add! Error#255</div>};
    }


    $c->render(
        '/shorturl/_added',
        short => $o{short},
        url => $i{url},
        error => $o{error}
    );

}
#end





1;

