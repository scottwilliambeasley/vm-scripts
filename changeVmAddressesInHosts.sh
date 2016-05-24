#!/bin/bash

##     --   NOTE   --
#  This script must be run as --root-- in order to change /etc/hosts
##


# Endlessly query the specified network interface for its assigned IP until we successfully retrieve one.


localNetworkDevice="wlp4s0";
networkStatus=false;


while [[ $networkStatus = 'false' ]]; do
    if  [[ -n "$(ip a s $localNetworkDevice | grep UP)" ]]; then
        ipAddress=$(ip a s $localNetworkDevice | grep 'inet ' | sed -r 's/inet (.*?)\/[[:digit:]]+.*/\1/')
        networkStatus=true;
    fi;
done;


# Once we've successfully retrieved the local IP, extract the local network address..


networkAddress=$(echo $ipAddress | sed -r 's/([[:digit:]]+).([[:digit:]]+).([[:digit:]]+).([[:digit:]]+)/\1.\2.\3/');


#we then create the address strings for each virtual machine


fileserverAddress=$networkAddress.251;
ldapserverAddress=$networkAddress.252;
droidphoneAddress=$networkAddress.253;


#we then replace our entries in /etc/hosts with the corresponding IP addresses to get static IPs


sed -ri "s/.* (fileserver.xyz fileserver)/$fileserverAddress \1/" /etc/hosts;
sed -ri "s/.* (ldapserver.xyz ldapserver)/$ldapserverAddress \1/" /etc/hosts;
sed -ri "s/.* (droidphone.xyz droidphone)/$droidphoneAddress \1/" /etc/hosts;

