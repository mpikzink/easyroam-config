# Easyroam Configuration Script (CLI)

## Background and Motivation

This project was initiated to address operational and compatibility issues encountered with the official **Easyroam Desktop Application** and its Snap-only distribution.

### Rationale

- The official Easyroam application is distributed exclusively as a SNAP package.
- SNAP is not desired in our environment due to limited integration like proxy and other system configurations.
- The Easyroam Desktop App has exhibited stability and compatibility problems:
  - Crashes or UI malfunctions in specific desktop environments (e.g., Wayland, KDE, HiRes Screens).
  - Failure to function under **Ubuntu 22.04**, application unusable in that context.

Given these constraints, an alternative solution was required to enable users to configure **eduroam/Easyroam** 
without relying on SNAP or encountering the aforementioned application issues.

---

## Origin of the Script

This script is a **derived and adapted version** of the Easyroam provisioning scripts originally published by **DFN (Deutsches Forschungsnetz)** collected from other universities.
It tries to avoid depedencies.

- The original DFN scripts require `sudo` privileges because the WLAN profile is configured system-wide.
- In my operational context, granting elevated privileges solely to configure a WiFi network is **not needed** and poses a security and policy concern.
- This project adapts the DFN logic to run entirely **within the user context**, without requiring root access, while still leveraging **NetworkManager** for configuration as user friendly as possible.

---

## Installation for Users
- Check `nmcli` and `openssl` are installed.
  `apt install nmcli openssl`
- Git-Clone/Copy `easyroam-config` script to your system.
  ``
- Check that it's executable
  `chmod u+x easyroam-config`
- Run the script to read the instructions
  `./easyroam-config`

---

## Installation for Administrators
- Build a deb package or us the provided dep-package to enroll the script for your users (sudo needed for installation).
- Run the script with user privileges to read the instructions
  `./easyroam-config`

---


