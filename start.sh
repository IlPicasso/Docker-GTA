sleep 3

CHK_FILE="/home/container/ts3server_minimal_runscript.sh"
if [ -f $CHK_FILE ]; then
    echo "Teamspeak executable exists, not downloading. To update, delete ts3server_minimal_runscript.sh."
else
    mkdir -p /home/container/.tmp-build
    cd /home/container/.tmp-build

    echo "> curl -sSLO http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2"
    curl -sSLO http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2

    echo "> tar -xjvf teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2"
    tar -xjvf teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2

    cp -rl teamspeak3-server_linux_amd64/* /home/container/.
    rm -r /home/container/.tmp-build

    cd /home/container
fi

if [ -f "/home/container/ts3server.ini" ]; then
    echo "ts3server.ini exists, not generating file."
else
    echo "machine_id=
default_voice_port=${SERVER_PORT}
voice_ip=0.0.0.0
licensepath=
filetransfer_port=30033
filetransfer_ip=
query_port=${SERVER_PORT}
query_ip=0.0.0.0
query_ip_whitelist=query_ip_whitelist.txt
query_ip_blacklist=query_ip_blacklist.txt
dbplugin=ts3db_sqlite3
dbpluginparameter=
dbsqlpath=sql/
dbsqlcreatepath=create_sqlite/
dbconnections=10
logpath=logs
logquerycommands=0
dbclientkeepdays=30
logappend=0
query_skipbruteforcecheck=0" > ts3server.ini
fi

cd /home/container
MODIFIED_STARTUP=`echo ${STARTUP} | perl -pe 's@\{\{(.*?)\}\}@$ENV{$1}@g'`
./ts3server_minimal_runscript.sh ${MODIFIED_STARTUP}
