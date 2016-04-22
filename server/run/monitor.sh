#!/bin/sh

#############################################################
# monitor server running                                    #
# restart server if detect it is not running                #
# monitor.sh must be in the same directory with the server    #
#############################################################
function sendSMS() {
}

function monitor() {
    if [ ! -e *.conf ]
    then
        echo "no config file"
        return
    fi
    echo $$ > monitor.pid

    if [ -e server.pid ]; then
        while true
        do
            pid=`cat server.pid`  # get pid
            process_count=`ps aux|grep $1|grep $pid|wc -l`
            if [ $process_count == 0 ]
            then
                # send a SMS
                sendSMS
                # add log
                date >> restart.log
                echo "server stopped, pid=$pid, process_cnt=$process_count" >> restart.log
                # restart server
                ../daeml ./$1
            fi
            sleep 15
        done
    fi
}

case $1 in    
    login_server)
        monitor $1
        ;;
    msg_server)
        monitor $1
        ;;
    route_server)
        monitor $1
        ;;
    http_msg_server)
        monitor $1
        ;;
    file_server)
        monitor $1
        ;;
    push_server)
        monitor $1
        ;;
    db_proxy_server)
        monitor $1
        ;;
    msfs)
        monitor $1
        ;;
    all)
        monitor login_server
        monitor msg_server
        monitor route_server
        monitor http_msg_server
        monitor file_server
        monitor push_server
        monitor db_proxy_server
        monitor msfs
        ;;
    test)
        sendSMS
        ;;
    *)
        echo "Usage: "
        echo "  ./monitor.sh (login_server|msg_server|route_server|http_msg_server|file_server|push_server|msfs)"
        echo "  ./monitor.sh all -- run all"
        ;;
esac
