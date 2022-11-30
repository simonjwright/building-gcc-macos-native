This is GCC 12.2.0 built on macOS Ventura (13, Darwin 22) but able to run on Monterey, for Apple silicon (M1), with Command Line Utilities 14.1.0 and Python 3.9.13.

**gcc-12.2.0-aarch64-apple-darwin21.pkg**

Compiler sources are from https://github.com/iains/gcc-12-branch at tag `gcc-12.2-darwin-r0`.

Compilers included: Ada, C, C++.

Tools included (all at version 23.0.0, and all with the  [Runtime Library Exception][RLE]):

* AUnit from https://github.com/AdaCore/aunit
* GNATCOLL from:
  * https://github.com/AdaCore/gnatcoll-core
  * https://github.com/AdaCore/gnatcoll-bindings (ZLIB is included, OMP and LZMA are not (the GNATCOLL version for LZMA requires thread support in the system library, not available on macOS))
  * https://github.com/AdaCore/gnatcoll-db (only the SQLite backend)
* Gprbuild from https://github.com/AdaCore/gprbuild
* Gprconfig\_kb from https://github.com/AdaCore/gprconfig_kb
* Langkit from https://github.com/AdaCore/langkit
* Libadalang from https://github.com/AdaCore/libadalang
* Libadalang tools from https://github.com/AdaCore/libadalang-tools
* Template Parser from  https://github.com/AdaCore/templates-parser
* XMLAda from https://github.com/AdaCore/xmlada

Target: aarch64-apple-darwin21

Configured with:
```
--prefix=/opt/gcc-12.2.0-aarch64
--without-libiconv-prefix
--disable-libmudflap
--disable-libstdcxx-pch
--disable-libsanitizer
--disable-libcc1
--disable-libcilkrts
--disable-multilib
--disable-nls
--enable-languages=c,c++,ada
--host=aarch64-apple-darwin21
--target=aarch64-apple-darwin21
--build=aarch64-apple-darwin21
--without-isl
--with-build-sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
--with-sysroot=
--with-specs='%{!sysroot=*:--sysroot=%:if-exists-else(/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk)}'
--with-build-config=no
--enable-bootstrap
```

[RLE]: http://www.gnu.org/licenses/gcc-exception-faq.html

## Install ##

One of _Xcode_ or the Command Line Tools is required.

_Xcode_ can be downloaded from the App Store.
Install the Command Line Tools by `sudo xcode-select --install`.

If you suspect your copy of the Command Line Tools is old, you can delete it by
```
sudo rm -rf /Library/Developer/CommandLineTools
```
and re-install.

Download the binary `.pkg`. It's not signed, so **don't** double-click on it; instead, right-click on it and _Open_. Accept the warning. You will be guided through the installation.

### Setting PATH ###

`PATH` needs to be set to include `/opt/gcc-12.2.0-aarch64/bin` at the front:

#### `bash` ####

Insert
```
export PATH=/opt/gcc-12.2.0-aarch64/bin:$PATH
```
in your `~/.bash_profile_common`.

#### `zsh` ####

Likewise, but in `~/.zshrc`.

See [here][ZSH] for helpful information on moving to `zsh`.

[ZSH]: https://scriptingosx.com/2019/06/moving-to-zsh/

## Notes ##

The software was built using the [building-gcc-macos-native][BUILDING] scripts at Github, tag `gcc-12.2.0-aarch64`.

All compilations were done with `export MACOSX_DEPLOYMENT_TARGET=12` so that libraries and executables are compatible with macOS Monterey and later.

[BUILDING]:https://github.com/simonjwright/building-gcc-macos-native

### Compiler ###

The compiler is GPL version 3. The runtime has the GCC Runtime Exception, so executables built with it can be released on proprietary terms.

### GMP, MPFR, MPC ###

These libraries (releases 6.2.1, 4.1.0, 1.2.1 respectively) are installed with the compiler.

### Other sources ###

The following patches to the v23.0.0 versions were needed to allow the builds to see the new compiler.

#### XML/Ada ####

```
diff --git a/Makefile.in b/Makefile.in
index 14d3dc4..26707d7 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -35,13 +35,9 @@ MODULES=unicode input_sources sax dom schema
 MODULE_INSTALL=${MODULES:%=%_inst}
 
 GPROPTS=-XXMLADA_BUILD_MODE=${MODE} -XPROCESSORS=${PROCESSORS}
+GPROPTS+=--target=${TARGET_ALIAS}
 
-ifeq (${HOST},${TARGET})
 IPREFIX=${DESTDIR}${prefix}
-else
-GPROPTS+=--target=${TARGET_ALIAS}
-IPREFIX=${DESTDIR}${prefix}/${TARGET_ALIAS}
-endif
 
 ifdef RTS
 GPROPTS+=--RTS=${RTS}
```

#### Gprbuild ####

```
diff --git a/Makefile b/Makefile
index d4de8894..6fddd346 100644
--- a/Makefile
+++ b/Makefile
@@ -37,13 +37,7 @@ LIB_DIR       = lib/
 # Load current setup if any
 -include makefile.setup
 
-# target options for cross-build
-ifeq ($(HOST),$(TARGET))
-GTARGET=
-# INSTALLER=exe/$(BUILD)/$(LIB_INSTALLER)
-else
 GTARGET=--target=$(TARGET)
-endif
 
 INSTALLER=$(LIB_INSTALLER)
 EXEC_INSTALLER=$(INSTALLER) -XBUILD=${BUILD}
```

### Include, library paths ###

As noted [here][SDKS], Apple have changed the location of system include files and libraries; they used to be copied from the SDKs to the "standard" `/usr/include` and `/usr/lib` either automatically or on command.

This compiler has been built so you don't need to take any related action to use it: unfortunately, this means that paths in `/usr/local` and `/Library/Frameworks` aren't searched.

[SDKS]: https://forward-in-code.blogspot.com/2022/03/which-sdk-choices-choices.html

## Distribution ##

The distribution was prepared using the [distributing-gcc project][DIST] at Github, tag `gcc-12.2.0-aarch64`.

[DIST]: https://github.com/simonjwright/distributing-gcc
