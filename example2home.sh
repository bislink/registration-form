# date
DATE=`date`;
#
DATE01=$(date '+%Y%m%d%H%M%S%Z');
#
DATE02=$(date '+%Y-%m-%d %H:%M:%S %Z');

CURRENT_USER=`echo $USER`;

#
PWD=""
USER_HOME_DIR=""
IP=""

#
if [ $CURRENT_USER = "root" ]
then
  PWD="/$CURRENT_USER/m/mojoapp"
  USER_HOME_DIR="/$CURRENT_USER"
  IP="192.168.1.225" # jail sumu from TrueNAS:231/194
else
  PWD="/home/$CURRENT_USER/m/mojoapp"
  USER_HOME_DIR="/home/$CURRENT_USER"
  IP="192.168.1.237"
fi

echo "e2h 27. PWD:$PWD; UHD:$USER_HOME_DIR; IP:$IP; HOST:$HOST; DIR:$DIR;";
echo "";

# Create Git files/stuff
GIT_FILES=".gitignore DEVELOPER.md ERROR.md SETUP.md CHANGELOG CONTRIBUTING LICENSE.md README.md";

SETTINGS_FILE=./.settings;

# app name
APPNAME="";
if [ "$1" = '' ]; then
	APPNAME='AppName';
	echo "USAGE: ";
	echo "$0 AppName";
	echo "";
	exit 0;
else
	APPNAME="$1";
	# add $1 to file
	if [ -f $SETTINGS_FILE ]
	then
		#
		echo "Showing content of $SETTINGS_FILE";
		`cat $SETTINGS_FILE`;
		echo "";
		#
	else
		# Create/initiate SETTINGS_FILE with $1
		echo "APP_NAME=$1" > $SETTINGS_FILE;

		# create lower case of $1
		LOWERCASE=$(echo "$1" | tr '[:upper:]' '[:lower:]');

		# append lowercase of $1 to file
		echo "YAML_NAME=$LOWERCASE.yml" >> $SETTINGS_FILE;

		# append some system/server data
		# PWD 
		echo "PWD=$PWD" >> $SETTINGS_FILE;
		# UHD
		echo "USER_HOME_DIR=$USER_HOME_DIR" >> $SETTINGS_FILE;
		# HOST
		echo "HOST=$HOST" >> $SETTINGS_FILE;
		# DIR 
		echo "DIR=$DIR" >> $SETTINGS_FILE;
		# IP4
		echo "IP4=$IP" >> $SETTINGS_FILE;
		# USER
		echo "CURRENT_USER=$CURRENT_USER" >> $SETTINGS_FILE;

	fi

fi

# DIR
DIR=.;

add_common_git_files () {

	for f in $GIT_FILES;
		do
			if [ -f $f ]; then
				echo "$f already exists";
				#echo "Adding current date to $f";
				#echo "$DATE" >> $f;
			else
				touch $f;
				echo "$DATE" >> $f;
				git add $f;
			fi
		done
}

#
if [ -d ./.git ]; then

	for f in $GIT_FILES;
		do
			if [ -f $f ]; then
				echo "$f already exists";
				#echo "Adding current date to $f";
				#echo "$DATE" >> $f;
			else
				touch $f;
				echo "$DATE" >> $f;
				git add $f;
			fi
		done

else

	echo "Initiating git";
	git init;

	# add common git files to current directory and git
	add_common_git_files
	# npm stuff
  rsync -az $USER_HOME_DIR/m/mojoapp/public/assets/node_modules ./public/assets/
	# append . to gitignore
	echo "script/hypnotoad.pid" >> ./.gitignore
	echo "public/assets/node_modules" >> ./.gitignore

	#Create/Initiate file APP_NAME.version  with 000 and date
	echo "000|$DATE01" > $APP_NAME.version

	echo "Adding all files in current directory to git";
	git add .;

	echo "first commit";
	git commit -am "000 Init. $DATE01";

	echo "DONE"

fi

#
if [ -d templates/example ]; then
	mv templates/example templates/home
fi

if [ -f lib/$APPNAME/Controller/Example.pm ]; then
	mv lib/$APPNAME/Controller/Example.pm lib/$APPNAME/Home.pm
fi

if [ -d lib/$APPNAME/Controller ]; then
	rm -rf lib/$APPNAME/Controller
fi

if [ -f ./create.sh ]; then
	rm -rf ./create.sh ./copy-login-mechanism.sh 
fi

# the following will not cause any problems/errors even if run multiple times
sed -i 's/example/home/' lib/$APPNAME.pm
# delete lines 4 through 9 (range of lines)
sed -i '4,9d' templates/home/welcome.html.ep
#
echo "Welcome to $APPNAME" >> templates/home/welcome.html.ep
#
sed -i 's/Controller::Example/Home/' lib/$APPNAME/Home.pm
sed -i "s/Welcome to the Mojolicious real-time web framework/Welcome to $APPNAME/" lib/$APPNAME/Home.pm
sed -i 's/example/home/' lib/$APPNAME/Home.pm
sed -i 's/Example/Home/' lib/$APPNAME.pm
sed -i 's/Example#welcome/Home#welcome/' lib/${APPNAME}.pm

# service worker
cp $USER_HOME_DIR/m/mojoapp/public/assets/service-worker.js public/assets/
sed -i "s/CreatemojoApp/$APPNAME/" public/assets/service-worker.js
# manifest
cp $USER_HOME_DIR/m/mojoapp/public/assets/manifest.json public/assets/
sed -i "s/CreatemojoApp/$APPNAME/" public/assets/manifest.json

# login and short url files 
sed -i "s/Createmojoapp/$APPNAME/" lib/*.pm
sed -i "s/Createmojoapp/$APPNAME/" lib/$APPNAME/*.pm
sed -i "s/Createmojoapp/$APPNAME/" lib/$APPNAME/Schema/Result/*.pm

# images
if [ -d public/assets/images ] && [ -d public/assets/images/icons ]
then
	echo "images/icons dir already exist"
else
	mkdir public/assets/images/icons -p
	wget bislinks.com/images/icons/192x192.png -O public/assets/images/icons/192x192.png
	wget bislinks.com/images/icons/512x5x2.png -O public/assets/images/icons/512x512.png
fi

echo "Get git status";
git status

echo "get git log -1";
git log -1 ;

echo "";
