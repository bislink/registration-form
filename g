#!/usr/bin/sh

#
DATE=$(date '+%Y%m%d%H%M%S%Z');

DATE02=$(date '+%Y-%m-%d %H:%M:%S %Z');

# NNN+1
NEXT_COMMIT_ID=`./pl/get_commit_id.pl`;

# get Next version
NEXT_VERSION=`./pl/get_next_version_number.pl`;

# NNN
CURRENT_COMMIT_ID=`./pl/get_current_commit_id.pl`;

# get NNN to N.N.N
CURRENT_VERSION=`./pl/get_current_version_number.pl`;

COMMIT_MESSAGE=;

YAMLNAME=`./pl/get_val_from_name.pl YAML_NAME`;

APP_NAME=`./pl/get_val_from_name.pl APP_NAME`;

VERSION_FILE="./$APP_NAME.version";
#
if [ -f "$VERSION_FILE" ]
then
  echo "Version file exists"
else
  touch "$VERSION_FILE";
fi

#
VISITS_FILE="./$APP_NAME.visits";

# create above two files if they do not exist
if [ -f "./$VISITS_FILE" ]
then
    TOTAL=`cat $VISITS_FILE`;
else
    echo "Visits File does not exist. Creating one";
    touch "./$VISITS_FILE";
fi

echo ""


if [ "$1" = '' ]; then

    # do not commit
        # just show status/log/etc.

    COMMIT_MESSAGE=$DATE;

    echo "Showing last commit from log"
    git log --oneline -5

    echo "Show Status"
    git status

else
    # if $1 is not empty, commit

    COMMIT_MESSAGE="$1";

    # update service-worker.js
    if [ -f "./public/assets/service-worker.js" ]
    then
        sed -i "s/$CURRENT_COMMIT_ID/$NEXT_COMMIT_ID/" public/assets/service-worker.js;
    else
        echo "File service-worker not found"
    fi

    echo ""

    # change version in .yml
    if [ -f "./$YAMLNAME" ]
    then
        sed -i "s/version: '$CURRENT_COMMIT_ID'/version: '$NEXT_COMMIT_ID'/" ./$YAMLNAME;
    else
        echo "File .yml not found"
    fi

    # Replace --version-- in dist.ini
    if [ -f "./dist.ini" ]
    then
        sed -i "s/version = $CURRENT_VERSION/version = $NEXT_VERSION/" ./dist.ini;
    else
        echo "g91. File dist.ini not found"
        echo ""
    fi

    # our $VERSION = '0.1.5';
    if [ -f "./lib/$APP_NAME/Home.pm" ]
    then
        sed -i "s/our \$VERSION = '$CURRENT_VERSION'/our \$VERSION = '$NEXT_VERSION'/" ./lib/$APP_NAME/Home.pm;
    else
        echo "g100. File ./lib/$APP_NAME/Home.pm not found"
        echo ""
    fi

    # write to CHANGELOG
    if [ -f "./CHANGELOG" ]
    then
        echo "$DATE02\n\tCommit ID: Old $CURRENT_COMMIT_ID | New $NEXT_COMMIT_ID\n\tVersion ID: Old $CURRENT_VERSION | New $NEXT_VERSION\n\n" >> CHANGELOG;
    else
        echo "File CHANGELOG not found"
        echo ""
    fi

    # write to README.md
    if [ -f "./README.md" ]
    then
        echo "#### $DATE02\n\n\tCommit ID: Old $CURRENT_COMMIT_ID | New $NEXT_COMMIT_ID\n\tVersion ID: Old $CURRENT_VERSION | New $NEXT_VERSION\n\n" >> README.md;
    else
        echo "File README.md not found"
        echo ""
    fi

    # write to DEVELOPER.md
    if [ -f "./DEVELOPER.md" ]
    then
        echo "#### $DATE02\n\nCommit ID: Old $CURRENT_COMMIT_ID | New $NEXT_COMMIT_ID\nVersion ID: Old $CURRENT_VERSION | New $NEXT_VERSION\n\n" >> DEVELOPER.md;
    else
        echo "File DEVELOPER.md not found"
        echo ""
    fi

    echo "$!";

    # h
    # also run hypnotoad hot deployment

    if [ -f ./h ]; then
        echo "hypnotoad hot deployment"
        ./h
    else
        echo "./h not found";
        echo ""
    fi

    echo "$!";

    echo "/$CURRENT_COMMIT_ID/$NEXT_COMMIT_ID/";

    echo ""

    if [ -f "$VERSION_FILE" ]
    then
        echo "$NEXT_COMMIT_ID|$DATE" > $VERSION_FILE;
    else
        echo "Version file does not exist. Creating one."
        touch "$VERSION_FILE";
    fi

    #
    echo "Committing Message"
    git commit -am "$NEXT_COMMIT_ID $COMMIT_MESSAGE $(date '+%Y%m%d%H%M%S') $CURRENT_COMMIT_ID";

    echo "$!"

    # c
    # copy/scp 

    if [ -f ./c ]; then
        echo "Copy/SCP files to another/test server"
        echo "Not running ./c"
        echo ""
    else
        echo "./c not found";
        echo ""
    fi

    # r
    # also push to repo automatically.
    echo "Push/update Git Lab Repo"

    REMOTE_ORIGIN=`git remote get-url --all origin`

    if [ -f ./r ]; then
        echo "Uploading to '${REMOTE_ORIGIN}'"
        ./r
        echo ""
    else
        echo "./r not found";
        echo ""
    fi

fi

echo "";

#echo "Latest Version number from $YAMLNAME ";
#grep -r 'version' $YAMLNAME;
#echo "";

#echo "Latest Version number from service-worker.js ";
#grep -r 'version' ./public/assets/service-worker.js;
#echo "";

if [ -f "$VERSION_FILE" ]
then
    echo "Latest version number from the actual 'app.version' file: '$VERSION_FILE'";
    cat $VERSION_FILE;
    echo "";
else
    echo "VERSION_FILE not found"
    echo ""
fi

#echo "Total Visits: (From $VISITS_FILE)";
#echo "$TOTAL";
#echo "";

echo "Total Commits";
git rev-list --count --all;
echo "";

#echo "$DATE";
#echo ""
