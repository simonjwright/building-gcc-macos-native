# Makefile to build a full GCC suite.
#
# The idea is to make each phase depend on the successful completion
# of the previous phase.

location := $(shell echo $(dir $(abspath $(lastword $(MAKEFILE_LIST)))) \
	| sed -e "s;/$$;;")

last: libadalang-tools

gcc: gcc-stamp
.PHONY: gcc
gcc-stamp: $(location)/common.sh $(location)/gcc.sh
	rm -f $@
	-mkdir gcc
	(cd gcc; $(location)/gcc.sh) 
	touch $@

gmp: gmp-stamp
.PHONY: gmp
gmp-stamp: gcc-stamp $(location)/common.sh $(location)/gmp.sh
	rm -f $@
	-mkdir gmp
	(cd gmp; $(location)/gmp.sh) && touch $@

mpfr: mpfr-stamp
.PHONY: mpfr
mpfr-stamp: gmp-stamp $(location)/common.sh $(location)/mpfr.sh
	rm -f $@
	-mkdir mpfr
	(cd mpfr; $(location)/mpfr.sh) && touch $@

mpc: mpc-stamp
.PHONY: mpc
mpc-stamp: mpfr-stamp $(location)/common.sh $(location)/mpc.sh
	rm -f $@
	-mkdir mpc
	(cd mpc; $(location)/mpc.sh) && touch $@

gprconfig: gprconfig-stamp
.PHONY: gprconfig
gprconfig-stamp: mpc-stamp $(location)/common.sh $(location)/gprconfig.sh
	rm -f $@
	-mkdir gprconfig
	(cd gprconfig; $(location)/gprconfig.sh) && touch $@

xmlada: xmlada-stamp
.PHONY: xmlada
xmlada-stamp: gprconfig-stamp $(location)/common.sh $(location)/xmlada.sh
	rm -f $@
	-mkdir xmlada
	(cd xmlada; $(location)/xmlada.sh) && touch $@

gprbuild: gprbuild-stamp
.PHONY: gprbuild
gprbuild-stamp: xmlada-stamp $(location)/common.sh $(location)/gprbuild.sh
	rm -f $@
	-mkdir gprbuild
	(cd gprbuild; $(location)/gprbuild.sh) && touch $@

aunit: aunit-stamp
.PHONY: aunit
aunit-stamp: gprbuild-stamp $(location)/common.sh $(location)/aunit.sh
	rm -f $@
	-mkdir aunit
	(cd aunit; $(location)/aunit.sh) && touch $@

gnatcoll-core: gnatcoll-core-stamp
.PHONY: gnatcoll-core
gnatcoll-core-stamp: aunit-stamp $(location)/common.sh $(location)/gnatcoll-core.sh
	rm -f $@
	-mkdir gnatcoll-core
	(cd gnatcoll-core; $(location)/gnatcoll-core.sh) && touch $@

gnatcoll-bindings: gnatcoll-bindings-stamp
.PHONY: gnatcoll-bindings
gnatcoll-bindings-stamp: gnatcoll-core-stamp $(location)/common.sh $(location)/gnatcoll-bindings.sh
	rm -f $@
	-mkdir gnatcoll-bindings
	(cd gnatcoll-bindings; $(location)/gnatcoll-bindings.sh) && touch $@

gnatcoll-db: gnatcoll-db-stamp
.PHONY: gnatcoll-db
gnatcoll-db-stamp: gnatcoll-bindings-stamp $(location)/common.sh $(location)/gnatcoll-db.sh
	rm -f $@
	-mkdir gnatcoll-db
	(cd gnatcoll-db; $(location)/gnatcoll-db.sh) && touch $@

libadalang: libadalang-stamp
.PHONY: libadalang
libadalang-stamp: gnatcoll-db-stamp $(location)/common.sh $(location)/libadalang.sh
	rm -f $@
	-mkdir libadalang
	(cd libadalang; $(location)/libadalang.sh) && touch $@

templates-parser: templates-parser-stamp
.PHONY: templates-parser
templates-parser-stamp: libadalang-stamp $(location)/common.sh $(location)/templates-parser.sh
	rm -f $@
	-mkdir templates-parser
	(cd templates-parser; $(location)/templates-parser.sh) && touch $@

libadalang-tools: libadalang-tools-stamp
.PHONY: libadalang-tools
libadalang-tools-stamp: templates-parser-stamp $(location)/common.sh $(location)/libadalang-tools.sh
	rm -f $@
	-mkdir libadalang-tools
	(cd libadalang-tools; $(location)/libadalang-tools.sh) && touch $@

# aunit
# gnatcoll-core
# gnatcoll-bindings
# gnatcoll-db
# libadalang
# templates-parser
# libadalang-tools
