#!/bin/sh

# install ems as service linux

# edit the following variables as required
EMSHOME=/opt/EMS_HOME
EMSVERSION=7.0
EMSUSERNAME=emsuser
# edit the above variables as required


su $EMSUSERNAME -c "mkdir $EMSHOME/ems/$EMSVERSION/scripts/"
cp shutdown  $EMSHOME/ems/$EMSVERSION/scripts/
cp ems-service-script.sh /etc/rc.d/init.d/ems7
chkconfig --add ems7

