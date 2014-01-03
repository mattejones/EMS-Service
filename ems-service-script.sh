#!/bin/sh
#
# chkconfig: 35 90 5
# description: EMS Service Scripts

. /etc/init.d/functions

# EMS Startup Script for linux.

#uncomment verbose to enable verbose logging.
verbose=true

## Configs
EMSUSERNAME="emsuser"						#ems username
EMSVERSION=7.0							#ems version
EMSCONFIGDIR="/opt/ems_conf/tibco/cfgmgmt/ems/data" 		#ems config dir
EMSHOMEDIR="/opt/EMS_HOME"					#ems home directory
EMSSERVICELOCK=""						#ems service lock


## Parent functions

verboseLog()
{
        if [ $verbose ]; then
                        echo $1 $2
        fi
}


## end parent functions

## Checks
getPort()
{
        # Here we get the configured EMS Port.
        verboseLog "Determining EMS Port Value"
        EMSPORT=$( grep "listen" $EMSCONFIGDIR/tibemsd.conf | grep -o '[0-9]\+' | tail -1)
        verboseLog "EMS Port value is" $EMSPORT
}

# Check EMS Port is free

checkPort()
{
        # Here we check if the port is inuse by any application.
        verboseLog "Checking if EMS port is in use, port to check: " $EMSPORT
	echo "Not yet implemented"
}


# Check Service Lock not in play?
# not yet implemented


# Start

start()
{
        # initlog -c "echo -n Starting EMS Server: "
		
        getPort
        checkPort
		verboseLog "Starting EMS with user:" $EMSUSERNAME
		verboseLog "Starting EMS from Directory: " $EMSCONFIGDIR
		verboseLog "Starting EMS EXECUTABLE from: " $EMSHOMEDIR
        su $EMSUSERNAME -c "cd $EMSCONFIGDIR ; nohup $EMSHOMEDIR/ems/7.0/bin/tibemsd64 &"
}

# Stop
stop()
{
        getPort
        # initlog -c "echo -n Stopping EMS Server: "
		verboseLog "Stopping EMS..."
		verboseLog "Stoppingg EMS using EXECUTABLE from: " $EMSHOMEDIR
        $EMSHOMEDIR/ems/7.0/bin/tibemsadmin64 -server "tcp://localhost:$EMSPORT" -user admin -script $EMSHOMEDIR/ems/7.0/scripts/shutdown
}


status()
{
		echo "NOT YET IMPLMENTED"
		getPort
		checkPort
}

### Servie Operations ###
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  status)
        status
        ;;
  restart|reload|condrestart)
        stop
        start
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|reload|status}"
        exit 1
esac
exit 0
