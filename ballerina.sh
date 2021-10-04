#!/bin/bash
set -E

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1

status() {

usr1="$@"

if [[ -z $("$usr1")  ]]
then
	echo "$usr1 is not be installed/not-in-the-path hence aborting BALLERINA install"
        exit
fi

}

statusins() {

usr2="$@"

chk2=`which $usr2`
chk2s="$?"

if [[ (( $chk2s != 0 )) ]]
then
	echo "command $usr2 in not pre installed, installing NOW"
	`sudo $cm1 -y install $usr2`
fi

}

pre() {

#status JAVA_HOME
statusins unzip

}


ball() {

balfile="1.2.19/ballerina-1.2.19.zip"	
balzip=`echo $balfile | awk '{split($0,a,"/"); print a[2]}'`	
balget=`wget https://dist.ballerina.io/downloads/$balfile`
balgets="$?"
if [[ (( $balgets != 0 )) ]]
then
	echo "Download of Ballerina zip file un-succesful"
	exit
fi

}

ballins() {

      	ball1="/usr/local/ballerina"
	if [[ ! -d "$ball1" ]]
	then
		`sudo mkdir "$ball1"`
	fi
        unz=`which unzip`
        s23="`sudo "$unz" ./"$balzip" -d "$ball1"`"
        balclean="${balzip::-4}"
        echo "balclaen is $balclean"
       	BALLERINA_HOME="$ball1/$balclean/bin"
	#/usr/local/ballerina/ballerina-1.2.19/bin
	echo "PATH=$PATH:$BALLERINA_HOME" | sudo tee -a /etc/profile

}


pre
ball
ballins
`which bal`
`bal --version`
