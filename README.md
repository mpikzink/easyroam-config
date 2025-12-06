# Easyroam Configuration Script (CLI)

## Background and Motivation

This project was initiated to address operational and compatibility issues encountered with the official **Easyroam Desktop Application** ands its Snap-only distribution.

### Rationale

- The official Easyroam application is distributed exclusively as a SNAP package since 8th July 2025. https://www.dfn.de/easyroam-linux/
- SNAP is not desired in our environment due to limited integration like proxy and the need of sudo privilegues for normal users.
- The Easyroam Desktop App has exhibited stability and compatibility problems we identified with our LTS Distros Ubuntu 22.04/24.04 :
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

## Installation instructions for Users

```bash
# Check existence for third party tools
command -v nmcli openssl

# Git-Clone/Copy `easyroam-config` script to your system.
wget https://git.mpi-hd.mpg.de/Packages/easyroam-config/raw/branch/main/easyroam-config

# Make it executable
chmod u+x easyroam-config
mkdir -p $HOME/bin
mv easyroam-config $HOME/bin

# Run the script to read the instructions
easyroam-config
```
---

## Installation instructions for Administrators
- Build a deb package with `make` or download the provided .deb package to enroll the script for your users (sudo needed for installation).
- Inform your users to run the script to read the instructions.
  `easyroam-config`

---
## Further Information
- Read the MAN page for the most detailed usage instructions. German and English are available:
  `man easyroam-config`
- https://www.easyroam.de
- https://eduroam.org
