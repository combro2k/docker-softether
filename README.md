# Docker image for SoftEther VPN

This will deploy a fully functional [SoftEther VPN](https://www.softether.org) server as a docker image.

Available on [Docker Hub](https://registry.hub.docker.com/u/combro2k/softether/).

## Download

    docker pull combro2k/softether

## Run

Simplest version:

    docker run -d --net host --name softether combro2k/softether

With external config file:

    docker run -d -v /etc/vpnserver/vpn_server.config:/usr/local/vpnserver/vpn_server.config --net host --name softether combro2k/softether

If you want to keep the logs in a data container:

    docker run -d --name softether-logs --volume /var/log/vpnserver busybox:latest /bin/true
    docker run -d --net host --name softether --volumes-from softether-logs combro2k/softether

All together now:

    docker run -d --name softether-logs --volume /var/log/vpnserver busybox:latest /bin/true
    docker run -d -v /etc/vpnserver/vpn_server.config:/opt/vpnserver/vpn_server.config --volumes-from softether-logs --net host --name softether combro2k/softether

TODO: Explain how to use a dnsmasq server inside the container and create a separate tap interface
