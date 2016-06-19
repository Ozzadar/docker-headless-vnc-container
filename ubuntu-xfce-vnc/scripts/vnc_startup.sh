#!/bin/bash
/usr/sbin/sshd -D &

##Launch pulse audio on startup
pulseaudio &

#resolve_vnc_connection
VNC_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
VNC_PORT="590"${DISPLAY:1}
NO_VNC_PORT="690"${DISPLAY:1}

##change vnc password
echo "change vnc password!"
(echo $VNC_PW && echo $VNC_PW) | vncpasswd

##start vncserver and noVNC webclient
$NO_VNC_HOME/utils/launch.sh --vnc $VNC_IP:$VNC_PORT --listen $NO_VNC_PORT &
vncserver -kill :1 && rm -rfv /tmp/.X* ; echo "remove old vnc locks to be a reattachable container"
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION
sleep 1
##log connect options
echo -e "\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
echo -e "\nnoVNC HTML client started:\n\t=> connect via http://$VNC_IP:$NO_VNC_PORT/vnc_auto.html?password=..."

## create link to VNC display
echo "export DISPLAY=localhost:1" >> /root/bashrc

## create symlinks to launch custom chrome version
ln -s /chrome/google-chrome /usr/bin/google-chrome 


echo 'Pulse audio loaded'

#set up audio sink and source
pactl load-module module-null-sink sink_name="cinnovator-virtual-audio-sink" sink_properties="device.description=cinnovator-virtual-audio-sink"
echo 'added sink'
pactl load-module module-virtual-source master=cinnovator-virtual-audio-sink.monitor source_name="cinnovator-virtual-audio-source" source_properties="device.description=cinnovator-virtual-audio-source"
echo 'added source'

for i in "$@"
do
case $i in
    # if option `-t` or `--tail-log` block the execution and tail the VNC log
    -t|--tail-log)
    echo -e "\n------------------ /root/.vnc/*$DISPLAY.log ------------------"
    tail -f /root/.vnc/*$DISPLAY.log
    ;;
    *)
    # unknown option ==> call command
    exec $i
    ;;
esac
done

