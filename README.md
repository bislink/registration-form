# Registration Form Creator

A registration form to collect business/user data

Requires Perl and Mojolicious installed on your Linux or WSL System

## Project

### Name
A Registration Form Creator

### URLs

#### Our own Git Lab Instance 
```https://git.biz-land.in/root/registration-form```

#### Official GitLab.com 
```https://gitlab.com/bizimpsol/registration-form.git```

### Start Date
Fri Oct 17 09:18:57 CDT 2025

### End Date

Fri Oct 17 11:20:43 CDT 2025
Fri Oct 17 14:23:58 CDT 2025

### Update App/Code/Template

RUN

```git pull```

#### The output will be somewhat similar to 

```
[rl@ns36 registration-form]$ git pull
warning: redirecting to https://git.biz-land.in/root/registration-form.git/
remote: Enumerating objects: 26, done.
remote: Counting objects: 100% (26/26), done.
remote: Compressing objects: 100% (17/17), done.
remote: Total 20 (delta 13), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (20/20), 2.10 KiB | 269.00 KiB/s, done.
From https://git.biz-land.in/root/registration-form
   d502a50..eb77b97  main       -> origin/main
Updating d502a50..eb77b97
Fast-forward
 CHANGELOG                | 15 +++++++++++++++
 DEVELOPER.md             | 18 ++++++++++++++++++
 README.md                | 43 ++++++++++++++++++++++++++++++++++++-------
 r                        | 12 ++++++++++++
 registrationform.version |  2 +-
 5 files changed, 82 insertions(+), 8 deletions(-)
[rl@ns36 registration-form]$
```

## Description

Create a registration form from items stored one per line in a text file

```APP_HOME_DIR/public/assets/form-elements.txt```

and modify it as many times as needed.

After modifying the `form-elements.txt` file, update the app by running `./h`, 
and refresh the app/web page to see latest changes

## Installation 

### Do the following to see it on your own PC :-: 

#### Log into a shell 

(command line utility/app) in a Unix/Linux/WSL system

#### RUN 
```
mkdir k/kishore/business -p
```

#### RUN 
```
cd k/kishore/business
```

#### RUN 
```
git clone https://git.biz-land.in/root/registration-form
```

#### RUN 
```
cd registration-form
```

#### RUN 
``` 
./h
```

#### OPEN 
```
http://localhost:10036/_form
```

in a browser to see it


## Install Perl / Mojolicious

### Windows / IIS

See README in 
```https://gitlab.com/bislink/pc-access-free``` 
for instructions on how to install/enable Perl/Mojolicious for IIS

### Linux 

On a command like or shell, 

#### Ubuntu / WSL 

RUN

```
sudo apt -y update && sudo apt -y upgrade;
sudo apt -y install perl
sudo cpan CPAN DateTime App::cpanminus
sudo cpanm Cpanel::JSON::XS CryptX EV IO::Socket::Socks Net::DNS::Native Role::Tiny Future::AsyncAwait Mojolicious
```

#### Rocky Linux

RUN

```
sudo dnf -y update
sudo dnf -y install perl
sudo cpan CPAN DateTime App::cpanminus
sudo cpanm CPAN Cpanel::JSON::XS CryptX EV IO::Socket::Socks Net::DNS::Native Role::Tiny Future::AsyncAwait Mojolicious
```

## Commits and Updates

### Automated Updates (Shown in descending order, by commit timestamp)

#### 2025-10-17 09:18:59 CDT

	Commit ID: Old 000 | New 001
	Version ID: Old 0.0.0 | New 0.0.1


#### 2025-10-17 09:19:00 CDT

	Commit ID: Old 001 | New 002
	Version ID: Old 0.0.1 | New 0.0.2


#### 2025-10-17 09:19:01 CDT

	Commit ID: Old 002 | New 003
	Version ID: Old 0.0.2 | New 0.0.3


#### 2025-10-17 09:19:02 CDT

	Commit ID: Old 003 | New 004
	Version ID: Old 0.0.3 | New 0.0.4


#### 2025-10-17 09:23:21 CDT

	Commit ID: Old 004 | New 005
	Version ID: Old 0.0.4 | New 0.0.5


#### 2025-10-17 09:38:26 CDT

	Commit ID: Old 005 | New 006
	Version ID: Old 0.0.5 | New 0.0.6


#### 2025-10-17 10:07:44 CDT

	Commit ID: Old 006 | New 007
	Version ID: Old 0.0.6 | New 0.0.7


#### 2025-10-17 10:09:53 CDT

	Commit ID: Old 007 | New 008
	Version ID: Old 0.0.7 | New 0.0.8


#### 2025-10-17 10:16:22 CDT

	Commit ID: Old 008 | New 009
	Version ID: Old 0.0.8 | New 0.0.9


#### 2025-10-17 10:17:15 CDT

	Commit ID: Old 009 | New 010
	Version ID: Old 0.0.9 | New 0.1.0


#### 2025-10-17 10:35:14 CDT

	Commit ID: Old 010 | New 011
	Version ID: Old 0.1.0 | New 0.1.1


#### 2025-10-17 10:39:24 CDT

	Commit ID: Old 011 | New 012
	Version ID: Old 0.1.1 | New 0.1.2


#### 2025-10-17 11:05:15 CDT

	Commit ID: Old 012 | New 013
	Version ID: Old 0.1.2 | New 0.1.3


#### 2025-10-17 11:05:47 CDT

	Commit ID: Old 013 | New 014
	Version ID: Old 0.1.3 | New 0.1.4


#### 2025-10-17 11:07:33 CDT

	Commit ID: Old 014 | New 015
	Version ID: Old 0.1.4 | New 0.1.5


#### 2025-10-17 11:33:58 CDT

	Commit ID: Old 015 | New 016
	Version ID: Old 0.1.5 | New 0.1.6


#### 2025-10-17 11:35:42 CDT

	Commit ID: Old 016 | New 017
	Version ID: Old 0.1.6 | New 0.1.7


#### 2025-10-17 11:38:09 CDT

	Commit ID: Old 017 | New 018
	Version ID: Old 0.1.7 | New 0.1.8


#### 2025-10-17 11:42:54 CDT

	Commit ID: Old 018 | New 019
	Version ID: Old 0.1.8 | New 0.1.9


#### 2025-10-17 11:48:14 CDT

	Commit ID: Old 019 | New 020
	Version ID: Old 0.1.9 | New 0.2.0


#### 2025-10-17 11:57:24 CDT

	Commit ID: Old 020 | New 021
	Version ID: Old 0.2.0 | New 0.2.1


#### 2025-10-17 13:27:14 CDT

	Commit ID: Old 021 | New 022
	Version ID: Old 0.2.1 | New 0.2.2


#### 2025-10-17 13:41:45 CDT

	Commit ID: Old 022 | New 023
	Version ID: Old 0.2.2 | New 0.2.3


#### 2025-10-17 13:43:34 CDT

	Commit ID: Old 023 | New 024
	Version ID: Old 0.2.3 | New 0.2.4


#### 2025-10-17 13:46:23 CDT

	Commit ID: Old 024 | New 025
	Version ID: Old 0.2.4 | New 0.2.5


#### 2025-10-17 13:56:02 CDT

	Commit ID: Old 025 | New 026
	Version ID: Old 0.2.5 | New 0.2.6


#### 2025-10-17 14:12:31 CDT

	Commit ID: Old 026 | New 027
	Version ID: Old 0.2.6 | New 0.2.7


#### 2025-10-17 14:32:35 CDT

	Commit ID: Old 027 | New 028
	Version ID: Old 0.2.7 | New 0.2.8


#### 2025-10-17 14:38:19 CDT

	Commit ID: Old 028 | New 029
	Version ID: Old 0.2.8 | New 0.2.9


#### 2025-10-17 14:42:05 CDT

	Commit ID: Old 029 | New 030
	Version ID: Old 0.2.9 | New 0.3.0


#### 2025-10-17 14:46:39 CDT

	Commit ID: Old 030 | New 031
	Version ID: Old 0.3.0 | New 0.3.1


#### 2025-10-17 15:03:49 CDT

	Commit ID: Old 031 | New 032
	Version ID: Old 0.3.1 | New 0.3.2


#### 2025-10-17 15:09:55 CDT

	Commit ID: Old 032 | New 033
	Version ID: Old 0.3.2 | New 0.3.3


#### 2025-10-17 15:26:32 CDT

	Commit ID: Old 033 | New 034
	Version ID: Old 0.3.3 | New 0.3.4


#### 2025-10-17 15:29:16 CDT

	Commit ID: Old 034 | New 035
	Version ID: Old 0.3.4 | New 0.3.5


#### 2025-10-17 15:51:16 CDT

	Commit ID: Old 035 | New 036
	Version ID: Old 0.3.5 | New 0.3.6


#### 2025-10-17 15:52:01 CDT

	Commit ID: Old 036 | New 037
	Version ID: Old 0.3.6 | New 0.3.7


#### 2025-10-17 15:55:43 CDT

	Commit ID: Old 037 | New 038
	Version ID: Old 0.3.7 | New 0.3.8


#### 2025-10-17 16:33:59 CDT

	Commit ID: Old  | New 
	Version ID: Old  | New 


#### 2025-10-17 16:37:03 CDT

	Commit ID: Old moved | New 001
	Version ID: Old  | New 


#### 2025-10-17 16:47:46 CDT

	Commit ID: Old 001 | New 002
	Version ID: Old  | New 0.0.2


#### 2025-10-17 16:49:48 CDT

	Commit ID: Old 002 | New 003
	Version ID: Old  | New 0.0.3


#### 2025-10-17 16:52:56 CDT

	Commit ID: Old 003 | New 004
	Version ID: Old 0.0.3 | New 0.0.4


#### 2025-10-17 16:56:33 CDT

	Commit ID: Old 004 | New 005
	Version ID: Old 0.0.4 | New 0.0.5


#### 2025-10-17 16:58:13 CDT

	Commit ID: Old 005 | New 006
	Version ID: Old 0.0.5 | New 0.0.6


#### 2025-10-17 17:04:22 CDT

	Commit ID: Old 006 | New 007
	Version ID: Old 0.0.6 | New 0.0.7


#### 2025-10-17 17:50:20 CDT

	Commit ID: Old 007 | New 008
	Version ID: Old 0.0.7 | New 0.0.8


#### 2025-10-17 17:51:54 CDT

	Commit ID: Old 008 | New 009
	Version ID: Old 0.0.8 | New 0.0.9


#### 2025-10-17 17:53:56 CDT

	Commit ID: Old 009 | New 010
	Version ID: Old 0.0.9 | New 0.1.0


