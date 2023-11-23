#!/bin/bash

addresses=("1.1.1.1" "8.8.8.8" "google.de" "10.0.0.66" "10.0.0.147" "10.0.0.129" "10.0.0.149" "10.0.0.1" "10.0.0.146" "10.0.0.97" "10.0.0.148" "10.0.0.145" "192.168.178.1")
results=()
for address in "${addresses[@]}"; do
	result=$(./ping.sh "$address")
	if [ $? -eq 0 ]; then
		result="Can Ping $address"
	else
		result="Cannot Ping $address"
	fi
	results+=("$result")
done

for ((i=0;i<${#results[@]}; i++)); do
	echo "Ergebnis $((i+1)): ${results[i]}"
done

