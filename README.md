# Building GCC for macOS #

This set of scripts supports building GCC Ada, or GNAT, on macOS as a native compiler, and then its supporting tools.

`python3` is required. If not installed, you can download a binary from [python.org](https://www.python.org).

## Building ##

Building is done in a set of shell scripts. The scripts are to some extent order-dependent, and this is catered for here by a Makefile.

The Makefile's targets are 
* `gcc`
* `gmp`
* `mpfr`
* `mpc`
* `gprconfig`
* `xmlada`
* `gprbuild`
* `aunit`
* `gnatcoll-core`
* `gnatcoll-bindings`
* `gnatcoll-db`
* `libadalang`
* `templates-parser`
* `libadalang-tools`
* `all`

Also, to support in particular `aarch64` builds of the two compiler components for Alire,
* `gcc-for-alire`
* `gprbuild-for-alire`

The scripts are named by adding `.sh` to the target.

Additionally, the script `gdb.sh` builds GDB (not useful on aarch64?)

### Building ###

The common information is in [`common.sh`](common.sh), which is sourced by the other scripts and sets environment variables.

### Building on Apple silicon ###

Building for `aarch64` is natural. Building for `x86_64` requires a little more work.

The Software Development Kits (SDKs) support both architectures. Once you have an `x86_64` compiler, you don't need to worry about this (fingers crossed), but for the GCC build you have to be running an `x86_64` shell:
```
arch -x86_64 /bin/bash
```
(you may need to set some environment variables, expecially the `PATH` that picks up the build compiler).

### Making ###

Some variables can be overridden during the `make` invocation:
* `VERSION`, e.g. `13.2.1` - the default is `13.2.0`. This controls where the built components are installed.
* `BOOTSTRAP`, e.g. `disable` - the default is `enable`; this controls the GCC build via the `configure` option `--$BOOTSTRAP-bootstrap`.

Assuming you've got this directory in `~/building-gcc-macos-native`, all your source code in <tt>~/gcc-src/<i>package-src</i></tt>, and you're going to build just `gprbuild` under `~/tmp/arch64`, you would say in `~/tmp/aarch64`
```
 make -f ~/building-gcc-macos-native/Makefile gprbuild \
     VERSION=13.2.1 BOOTSTRAP=disable
```
The individual components will appear in `gcc/`, `gprconfig/`, `xmlada/` and `gprbuild/`.

### Additional considerations for sources ###

* GCC relies on external maths libraries. To download and set them up, go to the top level of the GCC source directory and say
```
contrib/download_prerequisites
```
* *XML/Ada* requires *gprbuild*. In order to have built GCC, you must have had a compatible GNAT on your `PATH` already. Assuming that that GNAT contains a *gprbuild*, that should do (for example, the GCC 8.1.0 *XML/Ada* built OK with the GCC 7.1.0 *gprbuild*). If not, check out `bootstrap.sh` in the *gprbuild* sources.
* `gprbuild`: update `{gprbuild}/gpr/src/gpr-version.ads` to match the current release state.
* `gnatmetric`, `gnatpp`, `gnatstub`, `gnattest`: update `{libadalang-tools}/src/utils-versions.ads` likewise.
* `libadalang` and `langkit` sources need to be kept synchronised.
