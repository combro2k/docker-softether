FROM combro2k/debian-debootstrap:8
MAINTAINER Martijn van Maurik <docker@vmaurik.nl>

ENV VERSION v4.18-9570-rtm-2015.07.26

RUN apt-get update && \
    apt-get -y -q install gcc make curl dnsmasq isc-dhcp-server radvd supervisor && \
    curl -L http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-${VERSION}-linux-x64-64bit.tar.gz | \
    tar -xzv -C /usr/local

WORKDIR /usr/local/vpnserver

RUN make i_read_and_agree_the_license_agreement && \
    apt-get purge -y -q --auto-remove gcc make && \
    apt-get clean && \
    rm -fr /var/lib/apt

ADD resources/supervisord.conf /etc/supervisor/supervisord.conf
ADD runner.sh /usr/local/vpnserver/runner.sh

RUN chmod 755 /usr/local/vpnserver/runner.sh

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
