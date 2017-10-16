#!/usr/bin env bash
# Modified version by @nourharidy

CONFIG_DIR=`pwd`

installDrivers() {
  cd ./rtlwifi_new_11043 || (echo "Drivers not found"; exit 1)
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
installDrivers
configureWiFi $CONFIG_DIR
restartWiFi
echo "Your WiFi is fixed. Enjoy!"
echo "If this doen't help, try changing rtl8723be.conf and repeating the process"
exit 0
