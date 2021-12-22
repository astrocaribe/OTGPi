# OTGPi
This gets you an quick way to setup a Raspberry Pi OTG (On The Go) with minimal effort.

It will set ssh for you, remove ssh keys for the default `pi@raspberrypi.local` user  
from `known_hosts` file, and set up WiFi for you, if you wish (just follow the prompt  
when you run the tool).

## Compatibility
Tested so far on the following Pi versions:
- Raspberry Pi Zero W V1.1
- Raspberry Pi 3 Model B Rev 1.2


# Under Construction
More to come, with guiding images!


# Initial setup
1. Download [Raspberry Pi Imager] and install Raspbian to the card.
   ![pi Imager]

2. Remove/reinstert SD mini card into computer and ensure `/Volume/boot` drive loads

3. Run `otg_pi` to set up for OTG.
   From command line, make sure you're in the git project folder, then run `otg_pi.sh`:
   ```bash
   $> ./otg_pi.sh
   ```
   If you forgot to reinsert the SD card, you may see an error:
   ![otg-pi]

4. Eject SD, and insert into Pi. Wait at least 90s for it to load fully on first boot.

5. SSH into pi, using default creds:  
   ```bash
   $> ssh pi@raspberry.local
   ```   
6. Change the following defaults on first boot, to reduce the risk of a hack:
   1. `sudo raspi-config`
   2. (1) -> S3: Change password for user `pi`
   3. (1) -> S4: Hostname (e.g. `testpi`)

7. Reboot pi, and ssh again using new host/password
    ```bash
    # Reboot
    $> sudo reboot

    # After reboot
    $> ssh pi@testpi.local
    ```
8. Once logged in again, update/upgrade Raspbian using this one-liner:
   ```bash
   $> sudo apt update; sudo apt full-upgrade`
   ```


### Credit
Based on this [OTG] guide.

[Raspberry Pi Imager]: https://www.raspberrypi.org/downloads/
[OTG]: https://gist.github.com/gbaman/975e2db164b3ca2b51ae11e45e8fd40a
[pi Imager]: images/pi-imager.png
[otg-pi]: images/otg-pi.png