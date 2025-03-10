#!/bin/sh


MAIN_DIR="$(pwd)"

FDK_AAC_SRC="$MAIN_DIR/fdk-aac-source"
PIPEWIRE_SRC="$MAIN_DIR/pipewire-source"

mkdir -p "$FDK_AAC_SRC" "$PIPEWIRE_SRC"

echo "***** Installing dependencies *****"

sudo apt update && sudo apt install -y \
  build-essential \
  libfdk-aac-dev \
  libebur128-dev \
  libfftw3-dev \
  git-buildpackage \
  git
sudo apt build-dep pipewire


echo "***** Build fdk-aac *****"

cd "$FDK_AAC_SRC"
git clone https://salsa.debian.org/multimedia-team/fdk-aac 
cd "$FDK_AAC_SRC/fdk-aac"
gbp buildpackage 

echo "*** installing libfdk packages ***"
sudo dpkg -i ../libfdk-aac2*.deb ../libfdk-aac-dev_*.deb

echo "***** Build Pipewire *****"

cd "$PIPEWIRE_SRC"
apt source pipewire
cp "$MAIN_DIR/aac.patch" "$PIPEWIRE_SRC"
cd "$PIPEWIRE_SRC/pipewire-*"
patch -p0 < ../aac.patch
debuild

echo "*** installing pipewire packages ***"
sudo dpkg -i ../libspa-0.2-bluetooth_*.deb \
             ../libspa-0.2-modules_*.deb \
             ../pipewire_*.deb \
             ../pipewire-pulse_*.deb \
             ../libpipewire-0.3-0t64_*.deb \
             ../gstreamer1.0-pipewire_*.deb \
             ../libpipewire-0.3-modules_*.deb \
             ../pipewire-bin_*.deb \
             ../pipewire-alsa_*.deb

