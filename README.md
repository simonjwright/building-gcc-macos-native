# Building GCC for macOS #

This set of scripts supports building GCC Ada, or GNAT, on macOS as a
native compiler, and then its supporting tools.

The order is important.

## Common ##

A common point is that some of the components need to be built 'out of
tree', that is *not* in their source directory. Others can only be
built 'in tree'.

The common information is in [`common.sh`](common.sh), which is
sourced by the other scripts and sets environment variables.

Assuming you've got this directory in `~/building-x86_64`, all your
source code in <tt>~/gcc-src/<i>package-src</i></tt>, and you're
going to build under `~/tmp/x86_64`, you would, for each component, in
`~/tmp/x86_64`:

<pre>
mkdir <i>package</i>
cd <i>package</i>
~/building-x86-64/<i>package</i>
</pre>

## Building ##

The scripts are to some extent order-dependent. An appropriate order
would be

* `gcc.sh`
* `xmlada.sh`
* `gprbuild.sh`
* `gnat_util.sh`
* `aunit.sh`
* `gnatcoll-core.sh`
* `gnatcoll-bindings.sh`
* `gnatcoll-db.sh`
* `asis.sh`
* `gdb.sh`

## Notes ##

*XML/Ada* requires *gprbuild*. In order to have built GCC, you must
have had a compatible GNAT on your `PATH` already. Assuming that that
GNAT contains a *gprbuild*, that should do (The GCC 8.1.0 *XML/Ada*
built OK with the GCC 7.1.0 *gprbuild*). If not, check out
`bootstrap.sh` in the *gprbuild* sources.
