#!/bin/bash
# Disconnect active VPN connections via NetworkManager

active_vpns=$(nmcli -t -f NAME,TYPE con show --active | grep -E ':vpn|:wireguard|:openvpn' | cut -d: -f1)

if [ -z "$active_vpns" ]; then
    notify-send "VPN" "No active VPN connections to disconnect"
    exit 0
fi

for vpn in $active_vpns; do
    if nmcli con down "$vpn"; then
        notify-send "VPN Disconnected" "$vpn"
    else
        notify-send "VPN" "Failed to disconnect $vpn"
    fi
done