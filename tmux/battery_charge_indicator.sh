#!/bin/bash

if [[ `uname` == 'Linux' ]]; then
    current_charge=$(cat /proc/acpi/battery/BAT1/state | grep 'remaining capacity' | awk '{print $3}')
    total_charge=$(cat /proc/acpi/battery/BAT1/info | grep 'last full capacity' | awk '{print $4}')
else
    battery_info=`ioreg -rc AppleSmartBattery`
    current_charge=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
    total_charge=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
fi

charge_percent=$((${current_charge} * 100 / ${total_charge}))
echo $charge_percent
