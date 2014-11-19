# SoftEther VPN server

FROM ubuntu:14.04
MAINTAINER Frank Rosquin <frank.rosquin@gmail.com>

RUN apt-get update &&\
        apt-get -y -q install gcc make wget isc-dhcp-server supervisor

ENV VERSION v4.12-9514-beta-2014.11.17

RUN wget http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-${VERSION}-linux-x64-64bit.tar.gz -O /tmp/softether-vpnserver.tar.gz &&\
        tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/local/ &&\
        rm /tmp/softether-vpnserver.tar.gz

WORKDIR /usr/local/vpnserver
RUN make i_read_and_agree_the_license_agreement
RUN apt-get purge -y -q --auto-remove gcc make wget

ADD resources/supervisord.conf /etc/supervisor/supervisord.conf

ADD runner.sh /usr/local/vpnserver/runner.sh
RUN chmod 755 /usr/local/vpnserver/runner.sh

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp

ENTRYPOINT ["/usr/bin/supervisord"]
