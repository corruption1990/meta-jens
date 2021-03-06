#!/bin/sh

test -r /etc/network/wifi/defaults && source /etc/network/wifi/defaults

test -x /etc/network/if-pre-up.d/wpa-supplicant && MODE=stop /etc/network/if-pre-up.d/wpa-supplicant

if [ -f /data/.shadow/.etc/wpa_supplicant.conf ] && grep -q ${wifi_module} ${wifi_modprobe_loaded_path}; then
    if [ $(lsmod | grep $wifi_module | wc -l) -eq 0 ]; then
	    modprobe $wifi_module
    fi
else
    exit 1
fi
