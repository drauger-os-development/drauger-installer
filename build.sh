#!/bin/bash
VERSION=$(cat DEBIAN/control | grep 'Version: ' | sed 's/Version: //g')
PAK=$(cat DEBIAN/control | grep 'Package: ' | sed 's/Package: //g')
ARCH=$(cat DEBIAN/control | grep 'Architecture: '| sed 's/Architecture: //g')
FOLDER="$PAK\_$VERSION\_$ARCH"
FOLDER=$(echo "$FOLDER" | sed 's/\\//g')
if [ "$ARCH" == "amd64" ]; then
	COMPILER="g++"
	ARGS="-m64"
elif [ "$ARCH" == "arm64" ]; then
	COMPILER="aarch64-linux-gnu-g++"
	ARGS=""
fi
mkdir ../"$FOLDER"
##############################################################
#							     #
#							     #
#  COMPILE ANYTHING NECSSARY HERE			     #
#							     #
#							     #
##############################################################
cd usr/share/drauger-installer
$COMPILER $ARGS -Wall -o "log-out" "log-out.cxx" && echo "log-out compiled successfully"
cd ../../..
##############################################################
#							     #
#							     #
#  REMEMBER TO DELETE SOURCE FILES FROM TMP		     #
#  FOLDER BEFORE BUILD					     #
#  AND BINARY FILES FROM SOURCE DIR
#							     #
#							     #
##############################################################
if [ -d bin ]; then
	cp -R bin ../"$FOLDER"/bin
fi
if [ -d etc ]; then
	cp -R etc ../"$FOLDER"/etc
fi
if [ -d usr ]; then
	cp -R usr ../"$FOLDER"/usr
fi
if [ -d lib ]; then
	cp -R lib ../"$FOLDER"/lib
fi
if [ -d lib32 ]; then
	cp -R lib32 ../"$FOLDER"/lib32
fi
if [ -d lib64 ]; then
	cp -R lib64 ../"$FOLDER"/lib64
fi
if [ -d libx32 ]; then
	cp -R libx32 ../"$FOLDER"/libx32
fi
if [ -d dev ]; then
	cp -R dev ../"$FOLDER"/dev
fi
if [ -d home ]; then
	cp -R home ../"$FOLDER"/home
fi
if [ -d proc ]; then
	cp -R proc ../"$FOLDER"/proc
fi
if [ -d root ]; then
	cp -R root ../"$FOLDER"/root
fi
if [ -d run ]; then
	cp -R run ../"$FOLDER"/run
fi
if [ -d sbin ]; then
	cp -R sbin ../"$FOLDER"/sbin
fi
if [ -d sys ]; then
	cp -R sys ../"$FOLDER"/sys
fi
if [ -d tmp ]; then
	cp -R tmp ../"$FOLDER"/tmp
fi
if [ -d var ]; then
	cp -R var ../"$FOLDER"/var
fi
if [ -d opt ]; then
	cp -R opt ../"$FOLDER"/opt
fi
if [ -d srv ]; then
	cp -R srv ../"$FOLDER"/srv
fi
cp -R DEBIAN ../"$FOLDER"/DEBIAN
cd ..
#DELETE STUFF HERE
rm "$FOLDER"/usr/share/drauger-installer/log-out.cxx
rm drauger-installer/usr/share/drauger-installer/log-out
#build the shit
#build config
if [ "$ARCH" == "amd64" ]; then
	echo "amd64, x86_64, x86, i386, i486, x64, all" > "$FOLDER"/etc/drauger-installer/arch.conf
elif [ "$ARCH" == "arm64" ]; then
	echo "arm64, arm, aarch64, aarch, armhf, all" > "$FOLDER"/etc/drauger-installer/arch.conf
else
	echo "all" > "$FOLDER"/etc/drauger-installer/arch.conf
fi
dpkg-deb --build "$FOLDER"
rm -rf "$FOLDER"
