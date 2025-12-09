PKGNAME := $(shell dpkg-parsechangelog --show-field Source)
PKGVERSION := $(shell dpkg-parsechangelog --show-field Version)
PKGARCH := $(shell dpkg-parsechangelog --show-field Arch)

.PHONY: build clean

build:
	dpkg-buildpackage --unsigned-source --unsigned-changes
	mv ../$(PKGNAME)_$(PKGVERSION)* .
	dh_clean

clean:
	dh_clean

