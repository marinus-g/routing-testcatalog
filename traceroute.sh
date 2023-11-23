#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <ip-to-traceroute> <hop-ip1> [<hop-ip2> ...]"
    exit 1
fi

# Extract the IP address to traceroute
target_ip="$1"
shift

# Iterate through the specified hops
for hop_ip in "$@"; do
    # Run traceroute and extract the first IP address from the output
    trace_output=$(traceroute -n -m 1 "$target_ip" | awk '{print $2}' | tail -n 1)

    # Check if the obtained IP matches the expected hop IP
    if [ "$trace_output" != "$hop_ip" ]; then
        echo "Error: Hop $hop_ip not matched. Found: $trace_output"
        exit 1
    fi
done

# If all hops match, print okay
echo "Okay: All hops matched."

