#!/bin/bash
#
# For use to reinitialize AIDE database.
# Writen 2/9/15
# By Kenny Say, ksay@localnet.com
# Usage:    sudo bash initdb.sh


echo "Do you want to reinitialize the AIDE database? [y/N] "
    read input
if [ "$input" == "y" -o "$input" == "Y" -o "$input" == "yes" -o "$input" == "YES" -o "$input" == "Yes" ]; then
    echo "Cleaning up previous new database file: /var/lib/aide/aide.db.new "
        rm /var/lib/aide/aide.db.new &
        pid=$!
            while kill -0 $pid 2> /dev/null; do
            echo -n "."
            sleep 0.5
        done
    echo ""

    echo "Initializing AIDE database from configuration file: /etc/aide/aide.conf "
    echo "This usually takes about 5 to 10 miunutes. "
        /usr/bin/aide --init --config=/etc/aide/aide.conf &
        pid=$!
            while kill -0 $pid 2> /dev/null; do
            echo -n "."
            sleep 0.5
        done

    echo "Removing previous database: /var/lib/aide/aide.db "
        rm /var/lib/aide/aide.db &
        pid=$!
            while kill -0 $pid 2> /dev/null; do
            echo -n "."
            sleep 0.5
        done
    echo ""

    echo "Deploying new databsae from /var/lib/aide/aide.db.new to /var/lib/aide/aide.db "
        cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db &
        pid=$!
            while kill -0 $pid 2> /dev/null; do
            echo -n "."
            sleep 0.5
        done
    echo ""

    echo "Checking system against new database. System status report will be located: /var/lib/aide/lastrun "
    echo "This usually takes about 5 to 10 miunutes. "
        /usr/bin/aide --check --config=/etc/aide/aide.conf > /var/lib/aide/lastrun &
        pid=$!
            while kill -0 $pid 2> /dev/null; do
            echo -n "."
            sleep 0.5
        done
    echo ""

    echo "Check the above for errors. "
    echo "If all went well reinitialization was successful. "
    echo "You can check system status report here: /var/lib/aide/lastrun "
else
    echo "AIDE database reinitialization aborted. No changes made. "
fi
