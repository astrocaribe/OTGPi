# OTGPi
This gets you an quick way to setup a Raspberry Pi OTG (On The Go) with minimal effort.

It will set ssh for you, remove ssh keys for the default `pi@raspberrypi.local` user
from `known_hosts` file, and set up WiFi for you, if you wish (just follow the prompt
when you run the tool).

## Compatibility
Tested so far on the following Pi versions:
- Pi Zero W V1.1

## Under Construction
More to come, with guiding images!

# Initial setup
1. Download [Raspberry Pi Imager] and install Raspbian to the card.
2. Remove/reinstert DS mini card into computer and ensure `/Volume/boot` drive loads
3. Run `otg_pi` to set up for OTG.
4. Eject SD, and insert into Pi. Wait at least 60s for it to load fully.
5. SSH into pi; `ssh pi@raspberry.local`
6. Change the following defaults on first boot, to reduce the risk of a hack:
   1. `sudo raspi-config`
   2. (1) Change password for user `pi`
   3. (2) Network Options
      1. (N1) Hostname
      2. (N2) Wi-Fi (if you pi supports it)
7. Reboot pi, and ssh again using new host/password
    `ssh pi@testpi.local`
8. Once logged in again, update/upgrade Raspbian:
    `sudo apt update; sudo apt full-upgrade`


### Credit
Based on this [OTG] guide.

[Raspberry Pi Imager]: https://www.raspberrypi.org/downloads/
[OTG]: https://gist.github.com/gbaman/975e2db164b3ca2b51ae11e45e8fd40a