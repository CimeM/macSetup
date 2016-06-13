#!/bin/bash
# declare an array called array and define 3 vales

#successlog file
LOGFILE="log.txt"
NOW=$(date)
SCRIPTFILE=`basename "$0"`
exec 3>&1 1>>${LOGFILE} 2>&1
echo -e "\n------ Installation of OSX configuration process started -------" 1>&2 # only logfile
echo "date: $NOW" 1>&2 # only logfile
echo "script file: $SCRIPTFILE" 1>&2 # only logfile
echo "error log: $LOGFILE" 1>&2 # only logfile
echo "user: $USER" 1>&2 # only logfile

declare -a arr=()



#
# Install wget
#
arr+="brew install wget"

#
# install cocoapods
#
# arr[2]="sudo gem install cocoapods" this does not work for el capitan
arr+="sudo gem install -n /usr/local/bin cocoapods"

#
# dropbox
#
arr+="brew cask install dropbox"

#
# Chrome
#
arr+="brew cask install google-chrome"

#
# vlc
#
arr+="brew cask install vlc"

#
#sublime
#
arr+="brew cask install sublime-text"

#
#slack
#

arr+="brew cask install slack"

#
#flux
#
arr+="brew cask install flux"

#
#arduino
#
arr+="brew cask install arduino"


#
#filezilla
#
arr+="brew cask install filezilla"

#
#firefox
#
arr+="brew cask install firefox"

#
#evernote
#
arr+="brew cask install evernote"

#
#SQL workbench
#
arr+="brew cask install mysqlworkbench"

#
#suspicious package
#
arr+="brew cask install suspicious-package"

#
# git flow
#
arr+="brew install git-flow-avh"

#
# Source tree
#
arr+="brew cask install sourcetree"

#
# homebrew cask
#
arr+="brew tap caskroom/cask"

#
#the program asks wether the user wants to install all the neccesary tools
echo "entering setup - user selects programs to install" | tee /dev/fd/3
index=0
for i in "${arr[@]}"
do
	echo "[$((index+1))/${#arr[@]} ]Do you want to install ${i##* }? [y/N]" | tee /dev/fd/3
	read -r -p "[y/N] "  response
	case $response in
    		[yY][eE][sS]|[yY])
			echo "user wants to install ${i##* }" 1>&2 #only to logfile
			# dont delete the array item
			;;
		*)
			echo "user doesent want to install ${i##* }" 1>&2 # only to logfile
			arr[$index]=""
	esac
	((index=index+1))
done

#
#display array content
#
echo "Programs to be installed: " 1>&3
for i in "${arr[@]}"
do
	echo "$i" 1>&2 #only to log file
done



#
# Check if Homebrew is installed
#
echo "instaling homebrew..." | tee /dev/fd/3
which -s brew
if [[ $? != 0 ]] ; then
       # Install Homebrew
        # https://github.com/mxcl/homebrew/wiki/installation
        /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"	else
        echo "homebrew installed, updating..." | tee /dev/fd/3
        brew update
fi

#
# install sequence for selected programs
#
echo "starting instalation"

for i in "${arr[@]}"
do
	echo "installing $i"
	if $i | tee /dev/fd/3 ; then
		echo "Instalation of ${i##* } successfull" | tee /dev/fd/3 #console and logfile
		echo "checking with brew:" 
		
	else
		echo "[ERR]instalation of ${i##* }  FALIURE"  tee /dev/fd/3 #console and logfile
	fi
done

echo "configuring bash profile" tee /dev/fd/3 #console and logfile

cp bash_profile ~/.bash_profile | tee /dev/fd/3 #console and logfile


#
#Screenshotts folder change
#
SCRSHTLOCATION="/Users/Martin/Dropbox/Photos/Screenshots/" 
echo "writing default screenshot location in $SCRSHTLOCATION ..." | tee /dev/fd/3 #console and logfile
defaults write com.apple.screencapture location $SCRSHTLOCATION; 1>&2  #console and logfile
killall SystemUIServer | tee /dev/fd/3 #console and logfile

#
#copy the hosts folder
# to prepare before shutdown TODO clone from other repo, check for permissions
#echo "copiing hosts file to location"
#cp hosts /etc/hosts  #console and logfile


#
#installing spellcheck and dictionaries
#
echo "spellcheck instalation" | tee /dev/fd/3
cp ./Spelling/* /Library/Spelling/. 1>&2


#
#setup program deleeting old screenshots from screenshots folder - 1 month
#
#TODO

#
#setup the program for dropbox and google drive quit when on cellular data 
#
#TODO

#
#other instalation scripts
# - illustrator, photoshop,

#
#cloning repositories
#illustrator

#
#at the end of instalation open the error log file
#
echo "opening log file" 1>&3  #only console

echo "finished" | tee /dev/fd/3 #both
open -a TextEdit $LOGFILE
