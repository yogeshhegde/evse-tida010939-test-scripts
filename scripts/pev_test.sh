#!/bin/bash

# Stop everest service
systemctl stop everest

# Check the status of cg5317-bringup service
systemctl status cg5317-bringup

# Check the status of cg5317-host service
systemctl status cg5317-host

# Load the PEV binaries (Optional)
# cp /lib/firmware/spi_sta_config.bin /lib/firmware/config.bin

# Start the pev process with seth0 interface in background
pev -p /etc/pev.ini -i seth0 &

# Configure seth0 interface with IP address and bring it up
ifconfig seth0 192.168.1.2/24 up

# Run iperf3 client connecting to 192.168.1.1 for 30 seconds
iperf3 -c 192.168.1.1 -t 30