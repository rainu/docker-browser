# docker-tor-browser
This contains a up-to-date Tor-Browser. For starting this image you can use the docker-tor-browser.sh-script. There are two modes:

    persistent mode - history and custom settings are stored (the docker container will be saved)
    $> docker-tor-browser.sh -p
    throw-away mode - history and other settings are thrown away after Tor-Browser will be closed
    $> docker-tor-browser.sh
