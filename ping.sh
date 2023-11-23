#!/bin/bash

if [ -z "$1" ]; then
	echo "InvalidAddress"
	exit 1;
fi

target_address="$1"

perform_test() {
	if ping -c 4 "$target_address"; then
		echo "Success"
		exit 0
	else
		echo "CantReach"
		exit 1
	fi
}

perform_test

