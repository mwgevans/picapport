#!/bin/sh
if [ ! -e /opt/picapport/.picapport/picapport.properties ]; then
    # create picapport.properties
    printf "%s\n%s\n%s\n%s\n%s\n%s\n" "server.port=8080" "robot.root.0.path=/srv/photos" "client.theme.darktheme=true" "client.theme.color=#34568B" "foto.jpg.usecache=2" "foto.jpg.cache.path=/srv/cache" "plugin.shadow.path=/srv/picapportshadowfiles"> /opt/picapport/.picapport/picapport.properties
    cp -R /opt/picapportgroovy ./.picapport/groovy
    cp -R /opt/picapportplugins/* ./.picapport/plugins/
fi
java "-Xms$XMS" "-Xmx$XMX" "-DTRACE=$DTRACE" -Duser.home=/opt/picapport -jar picapport-headless.jar

