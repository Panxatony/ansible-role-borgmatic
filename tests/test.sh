#!/usr/bin/env bash

SUCCESSES=()
FAILS=()

echo "Removing old Vagrant VMs"
vagrant destroy -f

for vm in $(vagrant status --machine-readable | cut -d',' -f 2 | uniq -u); do
    if vagrant up --provision "$vm"; then
        SUCCESSES+=("$vm")
    else
        FAILS+=("$vm")
    fi
    vagrant halt "$vm"
done

echo "Successfully ran on: ${SUCCESSES[*]}"
echo "Failed on: ${FAILS[*]}"

echo "Removing all successful VMs"
for vm in "${SUCCESSES[@]}"; do
    vagrant destroy -f "$vm"
done