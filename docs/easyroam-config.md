% easyroam-config(8) Extracts certificates from an Easyroam PKCS#12 file.
% Kevin Zink
% December 2025

# NAME

easyroam-config – Extracts certificates from an Easyroam
PKCS#12 file and sets up an eduroam Wi‑Fi connection.

# SYNOPSIS

**easyroam-config** *profile_name.p12*

# DESCRIPTION

**easyroam-config** is a shell script that automates the creation of an
**eduroam** WLAN profile. It uses the credentials from a PKCS#12 (.p12)
client certificate file provided by Easyroam *(https://www.easyroam.de)*.

# ARGUMENTS

*easyroam_p12_file*

:   Path to the Easyroam PKCS#12 file, which must first be downloaded
    from the Easyroam portal *(https://www.easyroam.de)*.
    The file contains the client certificate, the private key, and the
    CA chain for the eduroam service of your institution. These are
    extracted and stored as three separate `.pem` files for use with
    **NetworkManager**(8).

# OPTIONS

This script accepts the mandatory PKCS#12 file for setup, or alternatively
the following options:

**-h, \--help**

:   Show a help message and exit.

**-w\[days\], \--warn=\[days\]**

:   Display a GUI warning if the certificate will expire within the
    specified number of days. Default is 30 days if no value is given.

If incorrect arguments are provided, a help message will be shown.

# REQUIREMENTS

GNU/Linux system with **bash**(1),  
**NetworkManager** and its CLI tool **nmcli**(1) installed and in the PATH.  
OpenSSL (version 1.x or 3.x), with optional **-legacy** parameter for
compatibility with OpenSSL 3.  
An Easyroam-provided PKCS#12 file with valid eduroam credentials.

# SECURITY NOTES

The script generates a random password to protect the extracted client
private key. The unencrypted PKCS#12 source file should be deleted after
setup to avoid leakage of sensitive credentials. Deletion of the source
file is offered at the end of setup.  

Extracted files are stored under:
*CONFIG_DIR*.  
The private key file is protected with a random password, which is also
stored in **nm-settings-nmcli**(5) as `"agent-owned (0x1)"` for access by
NetworkManager via a keyring or KWallet.  

After successful setup, a **systemd.timer**(5) is created in the user
context. It checks the certificate expiry date daily and, starting 30
days before expiration, warns the user via **notify-send**(1).

# EXIT STATUS

The exit code of easyroam-config indicates whether the requested action
was successful, or what kind of error occurred.

0  
:   Successful execution.

1  
:   General script error.

2  
:   Invalid PKCS#12 file format or incorrect password.

3  
:   No Wi‑Fi module found.

# EXAMPLES

To set up eduroam using an Easyroam PKCS#12 file:

```
$ easyroam-config ~/Downloads/profile_name.p12
```

To check the expiry date:

```
$ easyroam-config -w30
```

This creates and stores certificates under *CONFIG_DIR*
and sets up a new eduroam connection via NetworkManager.

# AUTHOR

Written by Kevin Zink <kevin.zink@mpi-hd.mpg.de>, inspired by the DFN
manual setup guide.

# REPORTING BUGS

Bugs and improvement suggestions can be filed via the GIT repository:
https://github.com/mpikzink/easyroam-config/issues

# SEE ALSO

**nmcli**(1), **nm-settings-nmcli**(5), **openssl**(1),
**NetworkManager**(8), Easyroam Portal: https://www.easyroam.de,  
XDG Base Directory Specification:  
https://specifications.freedesktop.org/basedir/latest/

# DISCLAIMER

This script modifies system-wide NetworkManager profiles and processes
sensitive credentials. Use it with caution and only on systems under
your control.  
The authors and distributors accept no liability for credential
compromise or connection failures.
