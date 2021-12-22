#!/bin/bash
# Script to automate setting Raspberry Pi 3/Zero/Zero W for OTG operation

# Add an `ssh` file to enable ssh out of the box
function add_ssh_file() {
    echo "[SSH]"
    echo "Enabling ssh..."
    touch /Volumes/boot/ssh
    echo "ssh file added."
    echo
}

# Append to `config.txt`
function append_config_file() {
    echo "[config.txt]"
    echo "Appending to config.txt..."
    echo "dtoverlay=dwc2" >> /Volumes/boot/config.txt
    echo "config.txt updated."
    echo
}

# Append to `cmdline.txt`
function append_cmdline_file() {
    echo "[cmdline.txt]"
    echo "Appending to cmdline.txt..."
    cat /Volumes/boot/cmdline.txt | sed 's/rootwait/& modules-load=dwc2,g_ether/' > /Volumes/boot/tmp_file.txt
    mv /Volumes/boot/tmp_file.txt /Volumes/boot/cmdline.txt
    echo "cmdline.txt updated."
    echo
}

# Add wifi information to allow WiFi for Pi 3/Zero W
function add_wifi() {
    echo "SSID $1 will be applied to WiFi setup..."

    cat wpa_supplicant.conf | sed "s/<ssid>/$1/" | sed "s/<psk>/$2/" > /Volumes/boot/wpa_supplicant.conf
    echo "Wifi setup conplete."
}

# Reset ssh connection to raspberrypi.local
function reset_sshkey() {
    echo "[SSH Keygen]"
    echo "Regenerating ssk key for pi@raspberrypi.local..."
    ssh-keygen -R raspberrypi.local
    echo "ssh key for raspberrypi.local reset."
    echo
}

# Unmount the SD card to safely eject
function unmount_boot() {
    echo "Unmounting SD card..."
    diskutil unmount /Volumes/boot
    echo
}

# Check to see if the SD "boot" drive exists, else exit setup
if [ -d "/Volumes/boot" ] 
then
    echo "[Boot volume]"
    echo "boot directory exists! Setting up OTG..."
    echo

    add_ssh_file

    append_config_file

    append_cmdline_file

    echo "[WiFi]"
    read -p "Add Wifi information? [Y/n]: " addwifi
    if [ $addwifi == "y" ] || [ $addwifi == "Y" ]
    then
      read -p "SSID: " ssid
      read -p "PassPhrase: " passphrase

      add_wifi $ssid $passphrase
    else
        echo "Wifi will not be set."
        echo
    fi

    reset_sshkey

    unmount_boot
    echo "Your SD should be set for OTG! Remove SD, insert into Pi, and wait at least 90s for boot before using ssh."
else
    echo "Error: SD not loaded or Raspbian not istalled."
    exit 1
fi