package Createform::Admin;

# ABSTRACT: Admin, Create Mojo App

use Mojo::Base 'Mojolicious::Controller', -signatures;

=head2 Main Directory 

    set main directory for app
        and directory browser, in particular
            not using this but using $o{dir} instead
            See https://git.biz-land.com/ns21u2204/example2home/-/issues/1

=cut

use Mojo::File qw(curfile);
my $dir = '';
    $dir = curfile->dirname;
    $dir =~ s!\\!\/!g;
  

=head2 Dashboard 

=cut


sub dash ($self, %o) {

    if ( $self->session('user') ) {
        # user has already logged in: 
        # dashboard content 

        $o{dash} = ""; 

        # a few videos from this hour 
        $o{dash} .= qq{<article class="a-few-videos"> <h3>Welcome</h3> };
        
        $o{dash} .= qq{</article> };

        # dev
        $self->stash( dev => $o{dev} );
        # final output to stash:dash 
        $self->stash(dash => $o{dash} );
        # render 
        $self->render('admin/dash');

    } else {
        # user login 
        my $user = $self->param('user') || '';
        my $pass = $self->param('pass') || '';

        $self->render('dash') unless $self->users->check($user, $pass); 

        $self->session(user => $user);
        $self->flash(message => 'Thanks for logging in.');
        $self->redirect_to('login');
    }
}
# end dash 

=head2 Directory Browser

=cut

# Directory
  sub _dir ($c, %o) {

    $o{url} = $c->url_for('/')->to_abs;
        ##$o{url} =~ s!\/\/!\/!g;  # replace double slashes with a single slash

    our (@dirs, @files, $path);
    $o{dir} = $c->param('name') || $c->conf->{thisapp}->{dir}->{main} || $dir;
    chomp $o{dir};
    #$o{dir} =~ s!^\/!!;
    #
    if ( -d "$o{dir}" ) {
      my @dir = split(/\//, $o{dir} );

      #
      $o{breadcrumbs} = qq{<nav aria-label="breadcrumb"> <ol class="breadcrumb"> <li class="breadcrumb-item active" aria-current="page">Home</li>};

      for (@dir) {
        #
        $path = $o{dir};
        $path =~ s!$_.*!!;
        $path =~ s!\/\/!\/!g;
        ##$path =~ s!^\/!!;
        next if $_ =~ /^$/;
        #
        $o{breadcrumbs} .= qq{<li class="breadcrumb-item"> <a class="breadcrumbs" href="/admin/dir?name=$path/$_" title="$path/$_">$_</a> </li> }
      }

      $o{breadcrumbs} .= qq{</ol> </nav>};

      $o{out} .= qq{$o{breadcrumbs}};


      #
      if (opendir( $o{directory}, "$o{dir}" ) ) {
        #
        while ( my $item = readdir( $o{directory} ) ) {
          if ( $item =~ /[a-zA-Z0-9\.\-]/ ) {
            next if $item =~ /^\.+$/;
            if ( -d "$o{dir}/$item" ) { push(@dirs, "$o{dir}/$item"); }
            else { push(@files, "$o{dir}/$item"); }
            #
          } else {
            $o{out} = "Err #68";
          }
        }
        #
      }
      # dirs
      $o{out} .= qq{<table class="table table-bordered"><tr> <th colspan="3">Directories</th> </tr> 
        <tr>
            <th>Name</th>
            <th>Ren</th>
            <th>Rem</th>
            <th>Chm</th>
            <th>Go</th>
        </tr>
      };
      for (@dirs) {
        ##$_ =~ s!^\/!!;
        my $name = $_;
        $name =~ s!$o{dir}!!;
        ##$name =~ s!^\/!!;
        $o{out} .= qq{<tr> 
            <td>$name</td> 
            <td> <a href="/admin/_dir/_rename?name="$name" title="Rename">Ren</a>       </td>
            <td> <a href="/admin/_dir/_remove?name="$name" title="Rename">Del</a>       </td>
            <td> <a href="/admin/_dir/_chmod?name="$name" title="Change Mode">Chm</a>         </td>
            <td> <a href="/admin/dir?name=$_" title="Change to directory $name">Go</a> </td> 
        </tr>  
        };
      }
      $o{out} .= qq{</table>};


      # 
      # files
      $o{out} .= qq{<table class="table table-bordered"> 
        <tr> <th colspan="3">Files</th> </tr> 
        <tr>
            <th>See</th>
            <th>Ren</th>
            <th>Rem</th>
            <th>Chm</th>
            <th>Edit</th>
        </tr>
      };
      #
      for (@files) {
        #$_ =~ s!^\/!!;
        my $name = $_;
        $name =~ s!$o{dir}!!;
        #$name =~ s!^\/!!;

        #
        my ($files_under_public_or_not, $dirs_before, $dirs_after ) = ();
        
        if ( $_ =~ /public/ ) { 
          ( $dirs_before, $dirs_after ) = split(/public/, $_, 2);
          #
          $name =~ s!public!!g;
          #
          $dirs_after =~ s!$name!!g; 
          #
          $files_under_public_or_not .= qq{<a target="_blank" href="$dirs_after/$name" title="See $dirs_before $dirs_after $name (Works only under public dir. Opens in new window/tab)">$name</a> };
          # http://manifest.json/      http://manifest.json//manifest.json     http://log.20241201233640cst.txt/     http://localhost:10103/Shorty//log.20241201233640CST.txt

        } else {
          $files_under_public_or_not .= qq{$name};
        }

        #
        $o{out} .= qq{<tr>
            <td> $files_under_public_or_not </td>
            <td> <a href="/admin/_file/_rename?name="$name">Rename</a>       </td>
            <td> <a href="/admin/_file/_remove?name="$name">Remove</a>       </td>
            <td> <a href="/admin/_file/_chmod?name="$name">ChMod</a>         </td>
            <td> <a href="/admin/file?name=$_" title="Edit file $_">Edit</a> </td>
          </tr>
        };
      }
      $o{out} .= qq{</table>};
      #
    } else {
      $o{out} = qq{<div class="alert alert-warning">#127. Not a directory: $o{dir} </div>};
    }
    # 
    $c->render('admin/_dir/_dir', name => $o{dir}, out => $o{out} );
  }
  # end dir


=head2 File
  Show file in a textarea for editing
=cut

sub _file ($c, %o) {
    #
    $o{url} = $c->url_for('/')->to_abs;
    #
    my $file = $c->param('name');
    chomp $file;
    $file =~ s!([\$|\%|\^|\*])!!g;
    
    #
    $o{allowed_files_to_edit} = $c->conf->{thisapp}->{files}->{allowed};

    our (@dirs, @files, $path);
    #
    @files = split(/\//, $file);
    $o{dir} = $file;
    $o{dir} =~ s!$files[$#files]!!;
    chomp $o{dir};
    #$o{dir} =~ s!^\/!!;
    #
    if ( -d "$o{dir}" ) {
      my @dir = split(/\//, $o{dir} );
      #
      for (@dir) {
        #
        $path = $o{dir};
        $path =~ s!$_.*!!;
        $path =~ s!\/\/!\/!g;
        #
        $o{out} .= qq{<a href="$o{url}/admin/dir?name=$path/$_" title="change to dire $_">$_</a> }
      }
    } else {
      $o{out} = qq{ Not a dir $o{dir} 155}
    }
    #
    $o{out} .= qq{<div>Processing file $file </div>};
    #

    #my $f;
    if ( -f "$file" ) {
      #
      if ( $file =~ /($o{allowed_files_to_edit})$/ ) {
        #
        $o{out} .= qq{<form action="/admin/_file/_save" method="post">
        <input type="hidden" name="name" id="name" value="$file">
        <textarea name="filecont" id="filecont" class="form-item" rows="16" cols="95%">
        };
        #
        open( my $f, "<", "$file") or $o{error} = "$@";
        while ( my $line = <$f> ) {
          $line =~ s!\#!\#!g;
          $line =~ s!\<!&lt;!g;
          $line =~ s!\>!&gt;!g;
          $o{out} .= qq{$line};
        }
        close $f;
        #
        $o{out} .= qq{</textarea> <br/> <input type="submit" value="Save">};
      } else {
        $o{out} .= qq{This file is not in the list of allowed files to edit. #219};
      }
      #
    }

    #
    $c->render('admin/_file/_file', name => $file, out => $o{out}, error => $o{error} );
    #
  }
  # end file


1;

