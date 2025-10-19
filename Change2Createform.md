sed -i 's/registrationform::/Createform::/' ./lib/*.pm
ns21u2204@ns21:~/k/kishore/business/registrationform$ ls lib
Createform.pm  registrationform
ns21u2204@ns21:~/k/kishore/business/registrationform$ sed -i 's/registrationform::/Createform::/' ./lib/registrationform/*.pm
ns21u2204@ns21:~/k/kishore/business/registrationform$ mv ./lib/registrationform/ ./lib/Createform
ns21u2204@ns21:~/k/kishore/business/registrationform$ sed -i 's/registrationform::/Createform::/' ./lib/Createform/Schema/*.pm
sed: can't read ./lib/Createform/Schema/*.pm: No such file or directory
ns21u2204@ns21:~/k/kishore/business/registrationform$ ls lib
Createform  Createform.pm
ns21u2204@ns21:~/k/kishore/business/registrationform$ sed -i 's/registrationform::/Createform::/' ./lib/Createform/Schema/Result/*.pm

ns21u2204@ns21:~/k/kishore/business/registrationform$ ls
CHANGELOG  CONTRIBUTING  Createform.version  Createform.visits  Createform.yml  DEVELOPER.md  ERROR.md  LICENSE.md  README.md  SETUP.md  data  example2home.sh  g  h  lib  pl  public  r  script  sh  t  templates
ns21u2204@ns21:~/k/kishore/business/registrationform$ ls lib
Createform  Createform.pm
ns21u2204@ns21:~/k/kishore/business/registrationform$ ls lib/Createform
Admin.pm  Database.pm  Home.pm  Languages.pm  Schema  Schema.pm  Shorturl.pm  Users.pm
ns21u2204@ns21:~/k/kishore/business/registrationform$

ns21u2204@ns21:~/k/kishore/business/registrationform$ ./h
Can't load application from file "/home/ns21u2204/k/kishore/business/registrationform/script/registrationform": Can't find application class "registrationform" in @INC. (/home/ns21u2204/k/kishore/business/registrationform/lib /home/ns21u2204/perl5/lib/perl5/5.34.0/x86_64-linux-gnu-thread-multi /home/ns21u2204/perl5/lib/perl5/5.34.0 /home/ns21u2204/perl5/lib/perl5/x86_64-linux-gnu-thread-multi /home/ns21u2204/perl5/lib/perl5 /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.34.0 /usr/local/share/perl/5.34.0 /usr/lib/x86_64-linux-gnu/perl5/5.34 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl-base /usr/lib/x86_64-linux-gnu/perl/5.34 /usr/share/perl/5.34 /usr/local/lib/site_perl)
ns21u2204@ns21:~/k/kishore/business/registrationform$

ns21u2204@ns21:~/k/kishore/business/registrationform$ mv script/registrationform script/createform
ns21u2204@ns21:~/k/kishore/business/registrationform$ ./h
Cannot find current script '/home/ns21u2204/k/kishore/business/registrationform/script/registrationform' at /home/ns21u2204/perl5/lib/perl5/FindBin.pm line 183.
BEGIN failed--compilation aborted at /home/ns21u2204/perl5/lib/perl5/FindBin.pm line 183.
Compilation failed in require at /home/ns21u2204/perl5/lib/perl5/Mojo/Server.pm line 51.
ns21u2204@ns21:~/k/kishore/business/registrationform$

nano script/createform
ns21u2204@ns21:~/k/kishore/business/registrationform$
ns21u2204@ns21:~/k/kishore/business/registrationform$ ./h
Cannot find current script '/home/ns21u2204/k/kishore/business/registrationform/script/registrationform' at /home/ns21u2204/perl5/lib/perl5/FindBin.pm line 183.
BEGIN failed--compilation aborted at /home/ns21u2204/perl5/lib/perl5/FindBin.pm line 183.
Compilation failed in require at /home/ns21u2204/perl5/lib/perl5/Mojo/Server.pm line 51.
ns21u2204@ns21:~/k/kishore/business/registrationform$ ls script/
createform  hypnotoad.pid
ns21u2204@ns21:~/k/kishore/business/registrationform$ n

git add script/createform
ns21u2204@ns21:~/k/kishore/business/registrationform$ ls
CHANGELOG  CONTRIBUTING  Createform.version  Createform.visits  Createform.yml  DEVELOPER.md  ERROR.md  LICENSE.md  README.md  SETUP.md  data  example2home.sh  g  h  lib  pl  public  r  script  sh  t  templates
ns21u2204@ns21:~/k/kishore/business/registrationform$ mv Createform.yml createform.yml
ns21u2204@ns21:~/k/kishore/business/registrationform$ ./h
Cannot find current script '/home/ns21u2204/k/kishore/business/registrationform/script/registrationform' at /home/ns21u2204/perl5/lib/perl5/FindBin.pm line 183.
BEGIN failed--compilation aborted at /home/ns21u2204/perl5/lib/perl5/FindBin.pm line 183.
Compilation failed in require at /home/ns21u2204/perl5/lib/perl5/Mojo/Server.pm line 51.
ns21u2204@ns21:~/k/kishore/business/registrationform$

ns21u2204@ns21:~/k/kishore/business/registrationform$ nano h
ns21u2204@ns21:~/k/kishore/business/registrationform$ ./h
Starting hot deployment for Hypnotoad server 538374.
ns21u2204@ns21:~/k/kishore/business/registrationform$

Error on Browser after committing the sed changes:
ErrorController "registrationform::Home" does not exist at /home/ns21u2204/perl5/lib/perl5/Mojolicious.pm line 127.

ns21u2204@ns21:~/k/kishore/business/registrationform$ ./h
Can't load application from file "/home/ns21u2204/k/kishore/business/registrationform/script/createform": Configuration file "/home/ns21u2204/k/kishore/business/registrationform/createform.yml" missing, maybe you need to create it?
ns21u2204@ns21:~/k/kishore/business/registrationform$

ns21u2204@ns21:~/k/kishore/business/registrationform$ ./h
Starting hot deployment for Hypnotoad server 538374.
ns21u2204@ns21:~/k/kishore/business/registrationform$

8:12 PM 10/18/2025  Still same error on browser

8:18 PM 10/18/2025
string ("Createform::Database") as a HASH ref while "strict refs" in use at /home/ns21u2204/perl5/lib/perl5/Mojolicious/Controller.pm line 24.

ns21u2204@ns21:~/k/kishore/business/registrationform$ perlcritic lib/Createform/Database.pm
Subroutine prototypes used at line 19, column 1.  See page 194 of PBP.  (Severity: 5)
Subroutine prototypes used at line 60, column 1.  See page 194 of PBP.  (Severity: 5)
ns21u2204@ns21:~/k/kishore/business/registrationform$ perlcritic lib/Createform/Home.pm
Subroutine prototypes used at line 7, column 1.  See page 194 of PBP.  (Severity: 5)
Subroutine prototypes used at line 22, column 1.  See page 194 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 25, column 5.  See page 199 of PBP.  (Severity: 5)
Subroutine prototypes used at line 28, column 1.  See page 194 of PBP.  (Severity: 5)
Subroutine prototypes used at line 34, column 1.  See page 194 of PBP.  (Severity: 5)
Subroutine prototypes used at line 39, column 1.  See page 194 of PBP.  (Severity: 5)
ns21u2204@ns21:~/k/kishore/business/registrationform$ perlcritic lib/Createform/Languages.pm
Code before strictures are enabled at line 11, column 1.  See page 429 of PBP.  (Severity: 5)
Two-argument "open" used at line 32, column 10.  See page 207 of PBP.  (Severity: 5)
Two-argument "open" used at line 84, column 4.  See page 207 of PBP.  (Severity: 5)
ns21u2204@ns21:~/k/kishore/business/registrationform$ perlcritic lib/Createform/Schema/Result/Users.pm
lib/Createform/Schema/Result/Users.pm source OK
ns21u2204@ns21:~/k/kishore/business/registrationform$ perlcritic lib/Createform/Schema.pm
lib/Createform/Schema.pm source OK
ns21u2204@ns21:~/k/kishore/business/registrationform$ perlcritic lib/Createform/Shorturl.pm
Subroutine prototypes used at line 13, column 1.  See page 194 of PBP.  (Severity: 5)
Subroutine prototypes used at line 75, column 1.  See page 194 of PBP.  (Severity: 5)
Subroutine prototypes used at line 139, column 1.  See page 194 of PBP.  (Severity: 5)
Subroutine prototypes used at line 179, column 1.  See page 194 of PBP.  (Severity: 5)
Subroutine prototypes used at line 227, column 1.  See page 194 of PBP.  (Severity: 5)
Subroutine prototypes used at line 245, column 1.  See page 194 of PBP.  (Severity: 5)
ns21u2204@ns21:~/k/kishore/business/registrationform$ perlcritic lib/Createform/Users.pm
Subroutine prototypes used at line 10, column 1.  See page 194 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 33, col

