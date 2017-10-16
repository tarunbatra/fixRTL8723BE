# fixRTL8723BE
Some HP laptops with **Realtek rtl8723be NICs** having one antenna face problems connecting to WiFi. This repository provides an automated fix for the problem by installing the latest driver and making the necessary configurations.
The [original repo](https://github.com/tarunbatra/fixRTL8723BE) of this fork requires that you download the latest driver from another [Github repo](https://github.com/lwfinger/rtlwifi_new). I modified it to include the latest driver in the same repo since you probably don't have access to the internet each time you're tring to fix your wifi.

## Installation
Just clone this repo. To clone, run:

`git clone https://github.com/nourharidy/fixRTL8723BE`

## Usage
- `cd` to the project root
- Run `bash install.sh`
