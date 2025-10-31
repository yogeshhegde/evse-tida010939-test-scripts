#!/bin/bash

# Check if an interface parameter was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <interface>"
    echo "Example: $0 main_mcan0"
    exit 1
fi

# Store the interface name from parameter
INTERFACE=$1

# Validate that the interface is either main_mcan0 or main_mcan1
if [ "$INTERFACE" != "main_mcan0" ] && [ "$INTERFACE" != "main_mcan1" ] && [ "$INTERFACE" != "can2" ]; then
    echo "Error: Interface must be either main_mcan0, main_mcan1 or can2"
    exit 1
fi

# Configure and bring up the CAN interface
echo "Configuring $INTERFACE..."
ip link set "$INTERFACE" type can bitrate 1000000 dbitrate 4000000 fd on

echo "Bringing up $INTERFACE..."
ip link set "$INTERFACE" up

echo "Sending test message on $INTERFACE..."
cansend "$INTERFACE" 113##2AAAAAAAA

echo "Bringing down $INTERFACE..."
ip link set "$INTERFACE" down

echo "Done."