# Building GCC for macOS #

This set of scripts supports building GCC Ada, or GNAT, on macOS as a native compiler, and then its supporting tools.

The two major branches are:

* to build for Intel silicon, `x86_64-apple-darwin`
* to build for Apple silicon, `aarch64-apple-darwin`

`python3` is required. If not installed, you can download a binary from [python.org](https://www.python.org).

The order is important.

## Common ##

A common point is that some of the components need to be built 'out of tree', that is *not* in their source directory. Others can only be built 'in tree'.

The common information is in [`common.sh`](common.sh), which is sourced by the other scripts and sets environment variables.

Assuming you've got this directory in `~/building-gcc-macos-native`, all your source code in <tt>~/gcc-src/<i>package-src</i></tt>, and you're going to build under `~/tmp/x86_64`, you would, for each component, in `~/tmp/x86_64`:

<pre>
mkdir <i>package</i>
cd <i>package</i>
~/building-gcc-macos-native/<i>package</i>.sh
</pre>

## Building ##

GCC relies on external maths libraries (e.g. the [GNU Multiple Precision Arithmetic Library][GMP]). To download and set them up, go to the top level of the GCC source directory and say
```
contrib/download_prerequisites
```
The scripts below build the libraries in both static and relocatable forms.

[GMP]: https://gmplib.org

----

The scripts are to some extent order-dependent. An appropriate order
would be

* `gcc.sh`
* `gmp.sh`
* `mpfr.sh`
* `mpc.sh`
* `xmlada.sh`
* `gprconfig.sh`
* `gprbuild.sh`
* `aunit.sh`
* `gnatcoll-core.sh`
* `gnatcoll-bindings.sh`
* `gnatcoll-db.sh`
* `libadalang.sh`
* `templates-parser.sh`
* `libadalang-tools.sh`
* `gdb.sh`

## Notes ##

* *XML/Ada* requires *gprbuild*. In order to have built GCC, you must have had a compatible GNAT on your `PATH` already. Assuming that that GNAT contains a *gprbuild*, that should do (for example, the GCC 8.1.0 *XML/Ada* built OK with the GCC 7.1.0 *gprbuild*). If not, check out `bootstrap.sh` in the *gprbuild* sources.
* `gprbuild`: update `{gprbuild}/gpr/src/gpr-version.ads` to match the current release state.
* `gnatmetric`, `gnatpp`, `gnatstub`, `gnattest`: update `{libadalang-tools}/src/utils-versions.ads` likewise.
* `libadalang` and `langkit` sources need to be kept synchronised.
