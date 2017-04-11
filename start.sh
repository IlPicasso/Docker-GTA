sleep 3

CHK_FILE="/home/container/samp03svr"
if [ -f $CHK_FILE ]; then
    echo "Executable of SAMP exists, not downloading. To update, delete samp03svr."
else
    mkdir -p /home/container/.tmp-build
    cd /home/container/.tmp-build

    echo "> curl -sSLO http://files.sa-mp.com/samp037svr_R2-1.tar.gz"
    curl -sSLO http://files.sa-mp.com/samp037svr_R2-1.tar.gz

    echo "> tar -xjvf samp037svr_R2-1.tar.gz"
    tar -xjvf samp037svr_R2-1.tar.gz

    cp -rl samp03/* /home/container/.
    rm -r /home/container/.tmp-build

    cd /home/container
fi

if [ -f "/home/container/server.cfg" ]; then
    echo "server.cfg exists, not generating file."
else
    echo "lanmode 0
rcon_password changeme
maxplayers 50
port ${SERVER_PORT}
hostname SA-MP 0.3 Server
gamemode0 grandlarc 1
filterscripts base gl_actions gl_property gl_realtime
announce 0
query 1
weburl www.sa-mp.com
maxnpc 0
onfoot_rate 40
incar_rate 40
weapon_rate 40
stream_distance 300.0
stream_rate 1000" > ts3server.ini
fi

cd /home/container
MODIFIED_STARTUP=`echo ${STARTUP} | perl -pe 's@\{\{(.*?)\}\}@$ENV{$1}@g'`
./samp03svr