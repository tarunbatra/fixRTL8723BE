#!/usr/bin env bash

REPO="https://github.com/lwfinger/rtlwifi_new"
CONFIG_DIR=`pwd`
DRIVER_DIR="rtlwifi_new"

checkGit() {
  if git --version  &> /dev/null; then
    echo "Git found"
  else
    echo "Please install git and run this again"
    exit 1
  fi
}

verifyDrivers() {
  echo "Verifying drivers"
  if [ ! -d "$DRIVER_DIR" ]; then
    checkGit && git submodule init
  fi
}

installDrivers() {
  cd $DRIVER_DIR || (echo "Drivers not found"; exit 1)
  echo "Building drivers"
  if make && sudo make install; then
    echo "Drivers built successfully"
  else
    echo "Drivers couldn't be built. Exiting"
    exit 1
  fi
}
configureWiFi() {
  echo "Configuring the WiFi settings"
  cd $1
  if (cat ./setup.conf  | sudo tee /etc/modprobe.d/rtl8723be.conf); then
    echo "WiFi settings configured"
  else
    echo "Wifi settings couldn't be configured"
  fi
}

restartWiFi() {
  echo "Restarting WiFi"
  if sudo modprobe -r rtl8723be && sudo modprobe rtl8723be; then
    echo "WiFi restarted"
  else
    echo "Couldn't restart WiFi"
  fi
}

echo "Fixing Wifi"
verifyDrivers $REPO
installDrivers
configureWiFi $CONFIG_DIR
restartWiFi
echo "Your WiFi is fixed. Enjoy!"
echo "If this doen't help, try changing rtl8723be.conf and repeating the process"
exit 0
