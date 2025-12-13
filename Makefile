PKGNAME := $(shell dpkg-parsechangelog --show-field Source)
PKGVERSION := $(shell dpkg-parsechangelog --show-field Version)
PKGARCH := $(shell dpkg-parsechangelog --show-field Arch)
MAN = 

.PHONY: deb mab clean


all: man

man:
	pandoc -s -t man docs/easyroam-config.de.md -o share/man/easyroam-config.de.8
	pandoc -s -t man docs/easyroam-config.md -o share/man/easyroam-config.8

deb: man
	debuild
	mv ../$(PKGNAME)_$(PKGVERSION)* .
