# Makefile to build a full GCC suite.
#
# The idea is to make each phase depend on the successful completion
# of the previous phase.

location := $(shell echo $(dir $(abspath $(lastword $(MAKEFILE_LIST)))) \
	| sed -e "s;/$$;;")

# what architecture are we running? (will get arm64 or i386)
current_arch = $(shell arch)

# what architecture was the compiler built for?
aarch64 = $(findstring aarch64, $(shell gcc -print-libgcc-file-name))
x86_64  = $(findstring x86_64,  $(shell gcc -print-libgcc-file-name))

# check that the compiler matches the architecture
ifeq ($(current_arch),arm64)
  ifeq ($(aarch64),)
    $(error shell is aarch64 but current gcc is not)
  else
    export ARCH=aarch64
  endif
else
  ifeq ($(current_arch),i386)
    ifeq ($(x86_64),)
      $(error shell is x86_64 but current gcc is not)
    else
      export ARCH=x86_64
    endif
  else
    $(error unexpected architecure $(current_arch), expecting i386)
  endif
endif

# test:
# 	@echo "current_arch=$(current_arch)"
# 	@echo "aarch64=$(aarch64), x86_64=$(x86_64)"
# 	@echo "ARCH=$(ARCH)"

last: libadalang-tools

gcc: gcc-stamp
.PHONY: gcc
gcc-stamp: $(location)/common.sh $(location)/gcc.sh
	rm -f $@
	-mkdir gcc
	(cd gcc; $(location)/gcc.sh) && touch $@

gcc-for-alire: gcc-for-alire-stamp
.PHONY: gcc-for-alire
gcc-for-alire-stamp: $(location)/common.sh $(location)/gcc-for-alire.sh
	rm -f $@
	-mkdir gcc-for-alire
	(cd gcc-for-alire; $(location)/gcc-for-alire.sh) && touch $@

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
gprconfig-stamp: gcc-stamp $(location)/common.sh $(location)/gprconfig.sh
	rm -f $@
	-mkdir gprconfig
	(cd gprconfig; $(location)/gprconfig.sh) && touch $@

xmlada: xmlada-stamp
.PHONY: xmlada
# xmlada gets built by the build compiler
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

gprbuild-for-alire: gprbuild-for-alire-stamp
.PHONY: gprbuild-for-alire
# The script installs gprconfig itself.
# The script uses xmlada.gpr to
gprbuild-for-alire-stamp: gcc-for-alire-stamp \
    $(location)/common.sh $(location)/gprbuild-for-alire.sh \
    $(location)/xmlada.gpr
	rm -f $@
	-mkdir gprbuild-for-alire
	(cd gprbuild-for-alire; $(location)/gprbuild-for-alire.sh) && touch $@

aunit: aunit-stamp
.PHONY: aunit
aunit-stamp: gprbuild-stamp $(location)/common.sh $(location)/aunit.sh
	rm -f $@
	-mkdir aunit
	(cd aunit; $(location)/aunit.sh) && touch $@

gnatcoll-core: gnatcoll-core-stamp
.PHONY: gnatcoll-core
gnatcoll-core-stamp: gprbuild-stamp $(location)/common.sh $(location)/gnatcoll-core.sh
	rm -f $@
	-mkdir gnatcoll-core
	(cd gnatcoll-core; $(location)/gnatcoll-core.sh) && touch $@

gnatcoll-bindings: gnatcoll-bindings-stamp
.PHONY: gnatcoll-bindings
gnatcoll-bindings-stamp: gmp-stamp gnatcoll-core-stamp $(location)/common.sh $(location)/gnatcoll-bindings.sh
	rm -f $@
	-mkdir gnatcoll-bindings
	(cd gnatcoll-bindings; $(location)/gnatcoll-bindings.sh) && touch $@

gnatcoll-db: gnatcoll-db-stamp
.PHONY: gnatcoll-db
gnatcoll-db-stamp: gnatcoll-core-stamp $(location)/common.sh $(location)/gnatcoll-db.sh
	rm -f $@
	-mkdir gnatcoll-db
	(cd gnatcoll-db; $(location)/gnatcoll-db.sh) && touch $@

libadalang: libadalang-stamp
.PHONY: libadalang
libadalang-stamp: gnatcoll-bindings-stamp $(location)/common.sh $(location)/libadalang.sh
	rm -f $@
	-mkdir libadalang
	(cd libadalang; $(location)/libadalang.sh) && touch $@

templates-parser: templates-parser-stamp
.PHONY: templates-parser
templates-parser-stamp: gprbuild-stamp $(location)/common.sh $(location)/templates-parser.sh
	rm -f $@
	-mkdir templates-parser
	(cd templates-parser; $(location)/templates-parser.sh) && touch $@

libadalang-tools: libadalang-tools-stamp
.PHONY: libadalang-tools
libadalang-tools-stamp: libadalang-stamp templates-parser-stamp $(location)/common.sh $(location)/libadalang-tools.sh
	rm -f $@
	-mkdir libadalang-tools
	(cd libadalang-tools; $(location)/libadalang-tools.sh) && touch $@
