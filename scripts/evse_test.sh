#!/bin/bash

# Stop everest service
systemctl stop everest

# Check status of services
systemctl status cg5317-bringup
systemctl status cg5317-host

# Load the EVSE binaries (Optional)
# cp /lib/firmware/spi_cco_config.bin /lib/firmware/config.bin

# Start the evse process with seth0 interface in background
#evse -p /etc/evse.ini -i seth0 &

# Configure network interface
ifconfig seth0 192.168.1.1/24 up

# Start iperf3 server with 2-second interval reporting
iperf3 -s -i 2