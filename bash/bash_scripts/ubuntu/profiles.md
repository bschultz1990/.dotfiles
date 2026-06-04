## alsa_card.pci-0000_01_00.1
api.alsa.card.longname = "HDA NVidia at 0xa1080000 irq 17"

```text
Profiles:
off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
output:hdmi-stereo: Digital Stereo (HDMI) Output (sinks: 1, sources: 0, priority: 5900, available: yes)
output:hdmi-stereo-extra1: Digital Stereo (HDMI 2) Output (sinks: 1, sources: 0, priority: 5700, available: yes)
output:hdmi-stereo-extra2: Digital Stereo (HDMI 3) Output (sinks: 1, sources: 0, priority: 5700, available: no)
output:hdmi-stereo-extra3: Digital Stereo (HDMI 4) Output (sinks: 1, sources: 0, priority: 5700, available: no)
output:hdmi-surround-extra2: Digital Surround 5.1 (HDMI 3) Output (sinks: 1, sources: 0, priority: 600, available: no)
output:hdmi-surround71-extra2: Digital Surround 7.1 (HDMI 3) Output (sinks: 1, sources: 0, priority: 600, available: no)
output:hdmi-surround-extra3: Digital Surround 5.1 (HDMI 4) Output (sinks: 1, sources: 0, priority: 600, available: no)
output:hdmi-surround71-extra3: Digital Surround 7.1 (HDMI 4) Output (sinks: 1, sources: 0, priority: 600, available: no)
pro-audio: Pro Audio (sinks: 4, sources: 0, priority: 1, available: yes)
```



## alsa_card.usb-Generic_USB_Audio-00
api.alsa.card.longname = "Generic USB Audio at usb-0000:00:14.0-14, high speed"

Profiles:
		off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
		HiFi: HiFi 2.0 channels (sinks: 3, sources: 3, priority: 8000, available: yes)
		HiFi 7+1: HiFi 7.1 channels (sinks: 3, sources: 3, priority: 1, available: yes)
		HiFi 5+1: HiFi 5.1 channels (sinks: 3, sources: 3, priority: 1, available: yes)
		pro-audio: Pro Audio (sinks: 4, sources: 3, priority: 1, available: yes)



## alsa_card.usb-046d_HD_Webcam_C615_CC812750-00
api.alsa.card.longname = "HD Webcam C615 at usb-0000:00:14.0-9.4.3.2, high speed"

Profiles:
		off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
		pro-audio: Pro Audio (sinks: 0, sources: 1, priority: 1, available: yes)
		input:mono-fallback: Mono Input (sinks: 0, sources: 1, priority: 1, available: yes)



## alsa_card.usb-Focusrite_Scarlett_18i20_USB_00014818-00
api.alsa.card.longname = "Focusrite Scarlett 18i20 USB at usb-0000:00:14.0-10.1, high speed"

Profiles:
		off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
		output:multichannel-output+input:multichannel-input: Multichannel Duplex (sinks: 1, sources: 1, priority: 101, available: yes)
		output:multichannel-output: Multichannel Output (sinks: 1, sources: 0, priority: 100, available: yes)
		pro-audio: Pro Audio (sinks: 1, sources: 1, priority: 1, available: yes)
		input:multichannel-input: Multichannel Input (sinks: 0, sources: 1, priority: 1, available: yes)


```bash
bash pactl set-card-profile alsa_card.usb-Generic_USB_Audio-00 HiFi
notify-send "USB Audio" "Profile: HiFi"
```

```bash
pactl set-card-profile alsa_card.usb-Generic_USB_Audio-00 off
notify-send "USB Audio" "Profile: off"
```
