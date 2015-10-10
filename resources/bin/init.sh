#!/bin/bash

/usr/bin/supervisorctl start vpnserver

if [ ! -z "${TAP_DNSMASQ}" ]; then
    while ! ip -4 link show dev ${TAP_DNSMASQ} up; do
            sleep 1
    done > /dev/null 2>&1

    /usr/bin/supervisorctl start dnsmasq
fi