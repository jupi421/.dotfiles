#!/bin/bash
# F5 Networks (c) 2010-2015
# cli/svpn installation

INSTALLER=$0
BASH_LOC=/bin/bash
INSTALL_LOC=/usr/local/bin
UTIL_NAME=f5fpc
UTFILE=uninstall_F5.sh

LOCATION=`dirname "$0"`
PKG_PATH="./webinstaller"
PKG_NAME="./linux_sslvpn.pkg"

echo 
echo 
echo "F5 Linux CLI (command line interface ) Edge Client Installer"
echo 



exit_installer()
{
 OP=$1
 if [ $OP -eq 1 ] ; then
    echo "Installation cancelled"
 elif [ $OP -ne 0 ] ; then
    echo "Installation failed"
 else
    echo 
    echo Installation completed successfully
    echo;  echo 
    echo "--> $UTIL_NAME is installed in $INSTALL_LOC"
    echo "--> Please check "$UTIL_NAME --help" command to get started" 
    echo "--> Uninstaller located in /usr/local/lib/F5Networks/uninstall_F5.sh"
    echo; 
 fi
 exit $1
}

readYesNo()
{
while :
do
read answer
if [ "yes" == "$answer" ] ;then
  return 1
elif [ "no" == "$answer" ] ; then 
  return 0
else
  echo -n "Please type 'yes' or 'no': "
fi
done
}

if [ $UID ] && [ $UID -ne 0 ]
then
  echo "Superuser privileges required..."
  echo "Please try to run $INSTALLER with sudo or through root user account"
  echo "For example: sudo $INSTALLER"
  exit_installer 100
fi

cli_pid=$(pgrep f5fpc | awk '{print $1;}')
if [[ -n $cli_pid ]] ; then
 echo  "Client running already. Stopping...."
 cli_path=$(ls -l /proc/$cli_pid/exe | awk '{ print $10}')
 $cli_path --stop > /dev/null 2>&1
fi

sleep 1

check=$(pgrep f5fpc | awk '{print $1;}')
if [[ -n $check ]] ; then
 echo  "Unable to stop client. Terminating..." 
 kill -9 $check > /dev/null 2>&1
fi

echo -n "Would you like to install/update CLI client (yes/no)? "
readYesNo
cli=$?
svpn=$cli

if [ "$svpn" -eq 0 ] && [ "$cli" -eq 0 ]; then
 exit_installer 1;
fi

if test -f /bin/tar; then
 tar=/bin/tar;
elif test -f /usr/bin/tar; then 
 tar=/usr/bin/tar; 
else 
 echo "tar not found. Please install tar utility"; 
 exit_installer 101;
fi

cd "$LOCATION"
cd "$PKG_PATH"

chmod 0755 $PKG_NAME
$PKG_NAME
rm -rf ./Install.sh
rm -rf ./utils
$tar xpzf linux_sslvpn.tgz
rm -rf ./linux_sslvpn.tgz

HM_DIR=/usr/local/lib/F5Networks
mkdir -p $HM_DIR ; RET=$?
if [ $RET -ne 0 ] ; then
   echo creating $HM_DIR failed. Please check for permissions
fi

if [ "$svpn" -eq 1 ] ; then
 cp -Rf ./usr/local/lib/F5Networks/SSLVPN /usr/local/lib/F5Networks/
 RET=$?
 if [ $RET -ne 0 ] ; then
   echo copying SVPN libraries failed
 fi
fi

if [ "$cli" -eq 1 ] ; then
 cp ./usr/local/lib/F5Networks/f5fpc_* /usr/local/lib/F5Networks/
 RET=$?
 if [ $RET -ne 0 ] ; then
   echo copying CLI failed
 fi
fi

 cp ./usr/local/lib/F5Networks/uninstall_F5.sh /usr/local/lib/F5Networks/
 RET=$?
 if [ $RET -ne 0 ] ; then
   echo copying uninstaller failed
 fi

STR=$(file $BASH_LOC) ; echo $STR | grep "64-bit" ; RET=$? 
if [ $RET -eq 0 ] ; then
  ln -sf  /usr/local/lib/F5Networks/f5fpc_x86_64 $INSTALL_LOC/$UTIL_NAME 
  RET=$?
else
  ln -sf  /usr/local/lib/F5Networks/f5fpc_i386  $INSTALL_LOC/$UTIL_NAME 
  RET=$?
fi
if [ $RET -ne 0 ] ; then
  echo Linking CLI failed.
  echo "Please use f5fpc_i386 (32-bit) or f5fpc_x86_64 (64-bit) in /usr/local/lib/F5Networks/"
  echo as per your CPU type
fi

rm -rf ./usr
#Lauching with root/sudo create this dir with incorrect permissions
#This will be created when application launch
rm -rf ~/.F5Networks

chown -R root.root /usr/local/lib/F5Networks
chmod u+s /usr/local/lib/F5Networks/SSLVPN/svpn*
setcap cap_kill+ep /usr/local/lib/F5Networks/f5fpc_x86_64
setcap cap_kill+ep /usr/local/lib/F5Networks/f5fpc_i386

exit_installer 0

