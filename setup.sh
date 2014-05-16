#!/bin/sh

###
### Configuration section
###
### This script is for giving people a basic set of dot files using the
### '...' system. If you want to use your own custom versions of things,
### it should be enough to simply change the following variables.
###

DOTDOTDOT_SOFTWARE_REPO='git://github.com/ingydotnet/....git'
DOT_FILES_REPO='git://github.com/ingydotnet/dotdotdot.git'
DOT_SOURCE_ALIAS=dotdotdot

###



###
### Start of the install script:
###
echo 'This script will install and configure a basic ... setup.'
echo 'Many of your dot files will be overwritten, but everything will be'
echo 'backed up first, and can be easily restored with `... restore`.'
echo ''
echo 'Press Control-C to quit'
read -p 'Press Enter to install' x

# Initialize variables
DOT=$HOME/...
CONF=$DOT/conf
SRC=$DOT/src/$DOT_SOURCE_ALIAS

GIT=`which git`
PERL=`which perl`
CPIO=`which cpio`

# System sanity checks
if [ -z "$GIT" ]; then
    echo "Error: 'git' not installed."
    echo ''
    echo "You don't absolutely need git for '...' but this script requires it."
    exit
fi
if [ -z "$PERL" ]; then
    echo "Error: 'perl' not installed. Cannot continue."
    exit
fi
if [ -z "$CPIO" ]; then
    echo "Error: 'cpio' not installed. Cannot continue."
    exit
fi

# Check if already setup.
if [ -f $CONF ]; then
    echo ''
    echo 'This script is only intended for new ... quick installs.'
    echo "$CONF already exists."
    echo 'Cannot continue.'
    echo ''
    echo "If you really want to run this, remove $CONF"
    exit
fi
if [ -e $SRC ]; then
    echo ''
    echo "$SRC already exists."
    echo 'Cannot continue.'
    echo ''
    echo "If you really want to run this, remove $SRC"
    exit
fi

# Check for bash.
BASH=`perl -e 'print "OK" if shift =~ /bash/' $SHELL`
if [ "$BASH" != "OK" ]; then
    echo ''
    echo "This script has only been tested for the 'bash' shell."
    echo 'Are you sure you want to continue?'
    echo ''
    echo 'Press Control-C to quit'
    read -p 'Press Enter to install' x
fi

# If ... is not installed, get that first.
if [ ! -e $DOT ]; then
    $GIT clone $DOTDOTDOT_SOFTWARE_REPO $DOT || exit
fi

# Get a dot files repository
$GIT clone $DOT_FILES_REPO $SRC || exit

# Set up the conf file.
echo 'default:' > $CONF
echo ' dot_paths:' >> $CONF
echo ' - path: dotdotdot' >> $CONF

if [ -n "$DOTDOTDOT_METHOD" ]; then
    echo " install_method: $DOTDOTDOT_METHOD" >> $CONF
fi

# Run the ... installation!
$DOT/bin/... install || exit

# Say Goodbye...
echo ''
echo '... is now installed on your system. Please restart (or exec) your shell.'
echo 'Run "... help" to get more information.'
echo "Also read $DOT/README for full details."
echo ''
echo 'Enjoy!'
echo ''
