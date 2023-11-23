#!/bin/bash

# Überprüfe, ob mindestens zwei Argumente übergeben wurden (Startadresse und mindestens eine Zieladresse)
if [ $# -lt 2 ]; then
    echo "Bitte gib mindestens zwei Argumente ein (Startadresse und mindestens eine Zieladresse)."
    exit 1
fi

# Startadresse und Zieladressen aus den Argumenten extrahieren
start_address="$1"
target_addresses=("${@: -1}")

# Führe den Traceroute-Test durch
traceroute_result=$(traceroute "$start_address")

# Array mit erwarteten IP-Adressen initialisieren
expected_addresses=("${target_addresses[@]}")

# Überprüfe die Hops
current_hop=1
for expected_address in "${expected_addresses[@]}"; do
    # Finde die nächste Hop-Adresse in der Traceroute-Ausgabe
    hop_address=$(echo "$traceroute_result" | awk -v hop_number=$current_hop '$0 ~ hop_number {if(NR>1)print $2}')

    # Überprüfe, ob die aktuelle Hop-Adresse mit der erwarteten Adresse übereinstimmt
    if [ -z "$hop_address" ] || [ "$hop_address" != "$expected_address" ]; then
        echo "Fehler: Hop $current_hop hat die erwartete Adresse $expected_address nicht."
	echo "address: $hop_address"
        exit 1
    fi

    ((current_hop++))
done

# Alle erwarteten Adressen wurden gefunden
echo "Alle erwarteten Adressen wurden in den Hops gefunden."

