# docker-firefox
This contains a up-to-date Firefox (installed from ubuntu repository). This Firefox is also preconfigured to play Flash and use the Pulseaudio of the docker-host. For starting this image you can use the docker-firefox.sh-script. There are two modes:

    persistent mode - history and custom settings are stored in a host directory (volume)
    The settings/history will be stored in ~/.docker/rainu/firefox/ of the hostssystem.
    $> docker-firefox.sh -p
    throw-away mode - history and other settings are thrown away after Firefox will be closed
    $> docker-firefox.sh
