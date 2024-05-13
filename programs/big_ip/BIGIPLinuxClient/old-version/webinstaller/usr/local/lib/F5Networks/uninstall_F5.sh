#!/bin/bash
UTFILE=$0

echo "F5 Linux CLI Edge Client Uninstalling..."

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

#stopping SVPN process: hard kill tries if its running from web
check=$(pgrep svpn | awk '{print $1;}')
if [[ -n $check ]] ; then
 echo  "stopping svpn. Terminating..."
 sudo kill -SIGTERM $check > /dev/null 2>&1
 sleep 2
 check=$(pgrep svpn | awk '{print $1;}')
 if [[ -n $check ]] ; then
   sudo kill -SIGTERM $check > /dev/null 2>&1
 fi
 check=$(pgrep svpn | awk '{print $1;}')
 if [[ -n $check ]] ; then
   sleep 1
   sudo kill -SIGTERM $check > /dev/null 2>&1
 fi
fi


if [ -L /usr/local/bin/f5fpc ] ; then
 sudo rm -f /usr/local/bin/f5fpc
 echo removing /usr/local/bin/f5fpc
fi

HMDIR=/usr/local/lib/F5Networks/
sudo ls $HMDIR > /dev/null 2>&1
EXIST=$?
if [ $EXIST -eq 0 ] ; then
  A=$(sudo find $HMDIR -type f)
  for tfile in $A ; do
    echo removing $tfile
    sudo rm -f $tfile
  done
fi

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

echo -n "Remove user configuration? (yes/no)"
readYesNo
removeFiles=$?

if [ "$HOME" ] && [ -d "$HOME/.F5Networks" ] ; then
  A=$(find $HOME/.F5Networks -type f)
  for tfile in $A ; do
    if [ $removeFiles -eq 0 ] && [[ $tfile != $HOME/.F5Networks/*.log ]] ; then 
      echo skipping $tfile
      continue;
    else
      echo removing $tfile
      rm -f $tfile
    fi
  done
  if [ $removeFiles -eq 1 ] ; then 
    rm -rf $HOME/.F5Networks
  fi
fi

A=$(sudo find "/root/.F5Networks" -type f)
for tfile in $A ; do
  #this is to list the files bieng removed
  if [ $removeFiles -eq 0 ] && [[ $tfile != /root/.F5Networks/*.log ]] ; then 
    echo skipping $tfile
    continue;
  else
    echo removing $tfile
    sudo rm -f $tfile
  fi
  if [ $removeFiles -eq 1 ] ; then 
    sudo rm -rf /root/.F5Networks
  fi
done

echo;echo;
sudo rm -rf $HMDIR
echo "F5 Linux CLI Edge Client Uninstalled successfully"
#if system reboots then $UTFILE will linger
rm -f $UTFILE
exit 0
