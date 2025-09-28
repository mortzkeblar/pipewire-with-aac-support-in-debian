## Pipewire build with AAC support in Debian

This script takes care of the compilation of libfdk and pipewire with AAC support, since the official Debian package versions do not include it (at least not by default). This was tested on Debian 13 Trixie.


### Precompiled binaries from Void Linux 

Before building from source, it is recommended to [follow](https://www.reddit.com/r/linuxaudio/comments/11fgoqq/how_to_enable_bluetooth_aac_codec_in_pipewire/) this simpler solution. It simply consists of copying some precompiled binaries (from the Void Linux repositories) to the `/usr/lib/x86_64-linux-gnu/spa-0.2/bluez5/` directory.

> By the time you do this, the package version may have changed, so if you encounter an error running `wget`, check https://repo-fi.voidlinux.org/current/ to see the current version of the `libspa-bluetooth` package.
```
wget https://repo-fi.voidlinux.org/current/libspa-bluetooth-1.2.7_1.x86_64.xbps

sudo apt install libfdk-aac2t64 libfdk-aac-dev

tar -xf libspa-bluetooth-*_1.x86_64.xbps
cd ./usr/lib/spa-0.2/bluez5/
sudo cp libspa-codec-bluez5-aac.so /usr/lib/x86_64-linux-gnu/spa-0.2/bluez5/
sudo reboot
```

> Thanks to @PsiCodes for indicating the dependencies necessary to use this method



### Compile from source


```
git clone https://github.com/mortzkeblar/pipewire-with-aac-support-in-debian
cd pipewire-with-aac-support-in-debian 
chmod +x run.sh
./run.sh
sudo reboot
```
