#!/bin/bash

###NOTES:
#   For this script to function properly, the vm must be initially set to
#    use DHCP for IP configuration in order so that we can determine the proper
#    network address and default route. 
#
#   The Networking and Hostname sections must also be set up properly.
###

###NETWORKING SETUP
#   Set the following two variables to the proper values needed.
#
#	localNetworkDevice - set this to the interface the vm uses to communicate on the hosts'
#		network. Default is "eth0".
#	netMask - set this to the shorthand network mask associated with the interface.
#                Default value is "24".
#	defaultRoute - set this to the default route your vms will use
#
	localNetworkDevice="eth0"
	netMask="24"
	defaultRoute="192.168.254.254"
###

###HOSTNAME AND STATIC IP TABLE   
# This vm's hostname and desired static local IP address must be included the associative 
#    array $hosts list to include this vm's hostname and corresponding IP. 

	declare -A hosts

#    Add your entries directly to it below:

	hosts=(               \
	   ["fileserver"]=251 \
	   ["ldapserver"]=252 \
	);

###



# Endlessly query the specified network interface for its assigned IP until we successfully retrieve one.


networkStatus=false;

while [[ $networkStatus = 'false' ]]; do
    sleep 1;
    if  [[ -n "$(ip a s $localNetworkDevice | grep UP)" ]]; then
        ipAddress=$(ip a s $localNetworkDevice | grep 'inet ' | sed -r 's/inet (.*?)\/[[:digit:]]+.*/\1/')
        networkStatus=true;
    fi;
done;


# Once we've successfully retrieved the local IP, extract the local network address..


networkAddress=$(echo $ipAddress | sed -r 's/([[:digit:]]+).([[:digit:]]+).([[:digit:]]+).([[:digit:]]+)/\1.\2.\3/');


# Then we begin to flush all associated IP addresses with the interface, and add our own custom, static IP.


ip addr flush $localNetworkDevice;
ip addr add $networkAddress."${hosts[$(hostname -s)]}"/$netMask dev $localNetworkDevice;
ip a s $localNetworkDevice;


# We then add the default route for the vm.

ip route add default via $defaultRoute
