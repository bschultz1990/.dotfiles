```bash
#! /usr/bin/bash

# https://linuxvox.com/blog/linux-pactl/#querying-pulseaudio-information
# run 'pactl list sinks' to note the device.name
# run 'pactl list cards' to note the desired profile under 'Profiles:'
# Set up like the following:

pactl set-card-profile alsa_card.usb-Focusrite_Scarlett_18i20_USB_00014818-00 "HiFi (Direct1, Direct2, Line1, Line10, Line11, Line12, Line13, Line2, Line3, Line4, Line5, Line7, Line8, Line9, Mic1, Mic2, SPDIF1, SPDIF2, SPDIF3)"
notify-send "Scarlett 18i20 USB" "Profile: HiFi"

pactl set-card-profile alsa_card.usb-Focusrite_Scarlett_18i20_USB_00014818-00 pro-audio
notify-send "Scarlett 18i20 USB" "Profile: pro-audio"
```
