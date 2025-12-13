% easyroam-config(8) Extrahiert Zertifikate aus einer Easyroam PKCS#12-Datei.
% Kevin Zink
% Dezember 2025

# NAME

easyroam-config - Extrahiert Zertifikate aus einer Easyroam
PKCS#12-Datei und richtet eine eduroam-WLAN-Verbindung ein.

# SYNOPSIS

**easyroam-config** *profile_name.p12*

# BESCHREIBUNG

**easyroam-config** ist ein Shellskript, welches die Einrichtung eines
**eduroam** WLAN-Profils automatisiert. Es verwendet dabei die
Zugangsdaten aus einer von Easyroam *(https://www.easyroam.de)*
bereitgestellten PKCS#12 (.p12) Client‑Zertifikatsdatei.

# ARGUMENTE

*easyroam_p12_file*

:   Pfad zur Easyroam PKCS#12-Datei, die zuvor über das Easyroam-Portal
    *(https://www.easyroam.de)* heruntergeladen werden muss. Die Datei
    enthält sowohl das Client‑Zertifikat, den privaten Schlüssel als
    auch die CA‑Kette für den eduroam-Dienst Ihrer Institution. Diese
    Informationen werden extrahiert und für die Verwendung mit
    **NetworkManager**(8) in drei separaten .pem-Dateien gespeichert.

# OPTIONEN

Dieses Skript akzeptiert die obligatorische PKCS#12‑Datei zur
Einrichtung, oder alternativ die folgenden Optionen:

**-h, \--help**

:   Zeigt eine Hilfemeldung an und beendet das Programm.

**-w\[tage\], \--warn=\[Tage\]**

:   Zeigt eine Warnung in der GUI an, falls das Zertifikat innerhalb der
    angegebenen Anzahl von Tagen abläuft. Standardwert ist 30 Tage, wenn
    kein Wert angegeben wird.

Wenn falsche Argumente übergeben werden, wird eine Hilfenachricht angezeigt.

:   

# VORAUSSETZUNGEN

GNU/Linux‑System mit **bash**(1) NetworkManager und dessen
Kommandozeilenwerkzeug **nmcli**(1) müssen installiert und im Suchpfad
verfügbar sein. OpenSSL (Version 1.x oder 3.x), mit optionalem Parameter
**-legacy** für Kompatibilität bei der Verwendung von OpenSSL 3. Eine
von Easyroam bereitgestellte PKCS#12‑Datei mit gültigen
eduroam‑Anmeldedaten.

# SICHERHEITSHINWEISE

Das Skript erzeugt ein zufälliges Passwort, um den extrahierten privaten
Schlüssel des Clients zu schützen. Die unverschlüsselte
PKCS#12‑Quelldatei sollte nach der Einrichtung gelöscht werden, um ein
mögliches Auslesen sensibler Anmeldedaten zu vermeiden. Das Löschen der
Quelldatei wird bereits zum Ende der Einrichtung angeboten. Die
extrahierten Dateien werden unter: \$_CONFIG_DIR
gespeichert. Die Private Schlüsseldatei wird mit einem zufälligen
Passwort vor Zugriff geschützt. Das Passwort wird außerdem automatisch
\"agent-owned (0x1)\" **nm-settings-nmcli**(5) für den Zugriff durch
NetworkManager z.B. im Keyring bzw. KWallet abgelegt. Nach einer
erfolgreichen Einrichtung wird ein **systemd.timer**(5) im
Benutzerkontext gesetzt, der täglich das Ablaufdatum des Zertifikats
prüft und ab 30 Tage vor Ablauf des Zertifikats den User über
**notify-send**(1) warnt.

# DATEIEN

Die extrahierten Zertifikatsdateien werden im Verzeichnis
\$_CONFIG_DIR also unter
*${XDG_DATA_DIR:-\$HOME/.local/share}/easyroam-certs* gespeichert:

* *cert.pem*
* *privkey.pem*
* *chain.pem*

# RÜCKGABEWERT

Der Exit-Code von easyroam-config zeigt an, ob es die angefragte Aktion
erfolgreich durchführen konnte und falls nicht, welche Art von Fehler
aufgetreten ist.

0

:   Erfolgreiche Ausführung.

1

:   Allgemeiner Skriptfehler.

2

:   Ungültiges PKCS#12‑Dateiformat oder falsches Passwort.

3

:   Kein WLAN‑Modul gefunden.

# BEISPIELE

Zur Einrichtung von eduroam mit einer Easyroam PKCS#12-Datei:

    $ easyroam-config ~/Downloads/profile_name.p12

    Zum Prüfen des Ablaufdatums:

    $ easyroam-config -w30

Dies erstellt und speichert Zertifikate unter \$_CONFIG_DIR
und richtet eine neue eduroam‑Verbindung in NetworkManager ein.

# AUTOR

Geschrieben von Kevin Zink \<kevin.zink@mpi-hd.mpg.de\>, inspiriert
durch die DFN‑Anleitung zur manuellen Installation.

# FEHLER MELDEN

Fehler und Verbesserungsvorschläge können über das GIT‑Repository
gemeldet werden: https://github.com/mpikzink/easyroam-config/issues

# WEITERE INFORMATIONEN

**nmcli**(1), **nm-settings-nmcli**(5), **openssl**(1),
**NetworkManager**(8), Easyroam‑Portal: https://www.easyroam.de,
XDG Base Directory Specification: https://specifications.freedesktop.org/basedir/latest/

# HAFTUNGSAUSSCHLUSS

Dieses Skript verändert systemweite NetworkManager‑Profile und
verarbeitet sensible Anmeldedaten. Verwenden Sie es mit Vorsicht und nur
auf Systemen, die Sie unter eigener Kontrolle haben. Die Autoren und
Herausgeber übernehmen keine Haftung für die Kompromittierung von
Anmeldedaten oder Verbindungsfehler.
