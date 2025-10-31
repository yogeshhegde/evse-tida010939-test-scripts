#!/bin/bash

# Check if an argument was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <interface>"
    echo "Example: $0 main_mcan0"
    exit 1
fi

# Store the provided CAN interface
CAN_INTERFACE=$1

# Validate that the interface is either main_mcan0 or main_mcan1
if [ "$CAN_INTERFACE" != "main_mcan0" ] && [ "$CAN_INTERFACE" != "main_mcan1" ] && [ "$CAN_INTERFACE" != "can2" ]; then
    echo "Error: Interface must be either main_mcan0, main_mcan1 or can2"
    exit 1
fi

# Set up the CAN interface
echo "Setting up $CAN_INTERFACE with 1Mbps bitrate..."
ip link set "$CAN_INTERFACE" type can bitrate 1000000

# Bring the interface up
echo "Bringing up $CAN_INTERFACE..."
ip link set "$CAN_INTERFACE" up

# Send a test message
echo "Sending test message on $CAN_INTERFACE..."
cansend "$CAN_INTERFACE" 123#F00DCAFE

# Bring the interface down
echo "Bringing down $CAN_INTERFACE..."
ip link set "$CAN_INTERFACE" down

echo "Done!"