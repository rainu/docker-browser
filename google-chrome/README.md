# docker-chrome
This contains a up-to-date Chrome. This Chrome is also preconfigured to play Flash and use the Pulseaudio of the docker-host. For starting this image you can use the docker-chrome.sh-script. There are two modes:

    persistent mode - history and custom settings are stored in a host directory (volume)
    The settings/history will be stored in ~/.docker/rainu/chrome/ of the hostssystem.
    $> docker-chrome.sh -p
    throw-away mode - history and other settings are thrown away after Chrome will be closed
    $> docker-chrome.sh
