# docker-chromium
This contains a up-to-date Chromium (installed from ubuntu repository). This Chromium is also preconfigured to play Flash and use the Pulseaudio of the docker-host. For starting this image you can use the docker-chromium.sh-script. There are two modes:

    persistent mode - history and custom settings are stored in a host directory (volume)
    The settings/history will be stored in ~/.docker/rainu/chromium/ of the hostssystem.
    $> docker-chromium.sh -p
    throw-away mode - history and other settings are thrown away after Chromium will be closed
    $> docker-chromium.sh
