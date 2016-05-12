#!/bin/bash
# declare an array called array and define 3 vales

#
# Check if Homebrew is installed
#
which -s brew
if [[ $? != 0 ]] ; then
	# Install Homebrew
     	# https://github.com/mxcl/homebrew/wiki/installation
	/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
else
        brew update
fi




declare -a arr=( $CASK  $WGET $COCOAPODS $CURL $DROPBOX $CHROME)
arr[0]="brew tap caskroom/cask"


#
# Install cask
#
arr[0]="brew tap caskroom/cask"

#
# Install wget
#
arr[1]="brew install wget"

#
# install cocoapods
#
arr[2]="sudo gem install cocoapods"

#
# dropbox
#
arr[3]="brew cask install dropbox"

#
# Chrome
#
arr[4]="brew cask install google-chrome"


echo "starting instalation"

for i in "${arr[@]}"
do
	echo "installing $i"
	if $i ; then
		echo "Instalation successfull"
		echo "checking with brew:"
	else
		echo "instalation of $i FALIURE"
		exit
	fi
done

echo "configuring bash profile"

cp bash_profile ~/.bash_profile

echo "Instalation successfull"
