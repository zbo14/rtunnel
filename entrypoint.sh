#!/bin/sh

chmod 700 /home/rtunnel/.ssh
chmod 600 /home/rtunnel/.ssh/authorized_keys

/usr/sbin/sshd \
  -4De \
  -h /root/.ssh/id_ed25519 \
  -o AllowTcpForwarding=yes \
  -o AllowUsers=rtunnel \
  -o ClientAliveInterval=15 \
  -o GatewayPorts=no \
  -o PasswordAuthentication=no \
  -o PermitOpen=any \
  -o PermitRootLogin=no \
  -o Protocol=2 \
  -p $PORT
