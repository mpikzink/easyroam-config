PKGNAME := $(shell dpkg-parsechangelog --show-field Source)
PKGVERSION := $(shell dpkg-parsechangelog --show-field Version)
PKGARCH := $(shell dpkg-parsechangelog --show-field Arch)

PANDOC ?= pandoc

MANSECTION ?= 8

MANPAGE.md = $(PANDOC) --standalone $(PANDOCFLAGS) --to man -V section=$(MANSECTION)

%.$(MANSECTION): %.$(MANSECTION).md
		$(MANPAGE.md) $< -o man/$@


.PHONY: man build clean

build:
	dpkg-buildpackage --unsigned-source --unsigned-changes
	mv ../$(PKGNAME)_$(PKGVERSION)* .
	dh_clean

man: easyroam-config.8

clean:
	dh_clean

