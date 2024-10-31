This is GCC 14.2.0 built on macOS Sonoma (14, Darwin 23) for Apple silicon, with Command Line Utilities 15.3.0 and Python 3.9.13.

Compilers included: Ada, C, C++.

Compiler sources are from https://github.com/iains/gcc-14-branch at tag `gcc-14.2-darwin-r2`.
 
Tools included (all at version 24.0.0, and all with the  [Runtime Library Exception][RLE]):

* AdaSAT from https://github.com/AdaCore/AdaSAT
* AUnit from https://github.com/AdaCore/aunit
* GNATCOLL from:
  * https://github.com/AdaCore/gnatcoll-core
  * https://github.com/AdaCore/gnatcoll-bindings (ZLIB is included, OMP and LZMA are not (the GNATCOLL version for LZMA requires thread support in the system library, not available on macOS))
  * https://github.com/AdaCore/gnatcoll-db (only the SQLite backend)
* Gprbuild from https://github.com/AdaCore/gprbuild
* Gprconfig\_kb from https://github.com/AdaCore/gprconfig_kb
* GPR2 from https://github.com/AdaCore/gpr (but not the tools, some don't quite match the behaviour of corresponding tools in GPRbuild)
* Langkit from https://github.com/AdaCore/langkit
* Libadalang from https://github.com/AdaCore/libadalang
* Libadalang tools from https://github.com/AdaCore/libadalang-tools
* Templates Parser from  https://github.com/AdaCore/templates-parser
* VSS from https://github.com/AdaCore/VSS
* XMLAda from https://github.com/AdaCore/xmlada

Configured with:
```
--prefix=/Volumes/Miscellaneous3/aarch64/gcc-14.2.0-2-aarch64
--enable-languages=c,c++,ada
--build=aarch64-apple-darwin23
--with-sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/../MacOSX14.sdk
--with-specs='%{!-sysroot:--sysroot=%:if-exists-else(/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.sdk /Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk)}'
--with-bugurl=https://github.com/simonjwright/building-gcc-macos-native
--enable-bootstrap
CC='/Volumes/Miscellaneous3/aarch64/gcc-14.2.0-clt15-aarch64/bin/gcc
--sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk'
CXX='/Volumes/Miscellaneous3/aarch64/gcc-14.2.0-clt15-aarch64/bin/g++
--sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk'
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

`PATH` needs to be set to include `/opt/gcc-14.2.0-2-aarch64/bin` at the front:

#### `bash` ####

Insert
```
export PATH=/opt/gcc-14.2.0-2-aarch64/bin:$PATH
```
in your `~/.bash_profile_common`.

#### `zsh` ####

Likewise, but in `~/.zshrc`.

See [here][ZSH] for helpful information on moving to `zsh`.

[ZSH]: https://scriptingosx.com/2019/06/moving-to-zsh/

## Notes ##

The software was built using the [building-gcc-macos-native][BUILDING] scripts at Github, tag `gcc-14.2.0-2-aarch64`.

All compilations were done with `export MACOSX_DEPLOYMENT_TARGET=14` so that libraries and executables are compatible with macOS Sonoma and later.

[BUILDING]:https://github.com/simonjwright/building-gcc-macos-native

### Compiler ###

The compiler is GPL version 3. The runtime has the GCC Runtime Exception, so executables built with it can be released on proprietary terms.

### GMP ###

This library (release 6.2.1) is installed with the compiler.

### Other sources ###

The following patches to the v24.0.0 versions were needed to allow the builds to see the new compiler.

#### GNATColl Bindings

```
diff --git a/python3/setup.py b/python3/setup.py
index 18a29157..15c00c21 100755
--- a/python3/setup.py
+++ b/python3/setup.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 import logging
 import sys
 import re
```

#### GPR2

```
diff --git a/Makefile b/Makefile
index ce203ff9..82799b1c 100644
--- a/Makefile
+++ b/Makefile
@@ -47,7 +47,11 @@ TARGET := $(shell gcc -dumpmachine)
 #
 # first let's check if Makefile is symlinked: realpath will return the actual
 # (after link resolution) relative path of the Makefile from PWD.
+ifeq ($(shell uname -s),Darwin)
+MFILE         := $(shell realpath "$(firstword ${MAKEFILE_LIST})"))
+else
 MFILE         := $(shell realpath --relative-to=. "$(firstword ${MAKEFILE_LIST})"))
+endif
 # as Makefile is in the root dir, SOURCE_DIR is just dirname of the Makefile
 # path above.
 SOURCE_DIR    := $(shell dirname "${MFILE}")
```

#### GPRBuild

```
diff --git a/gpr/src/gpr-version.ads b/gpr/src/gpr-version.ads
index 4238bedf..60a42c2c 100644
--- a/gpr/src/gpr-version.ads
+++ b/gpr/src/gpr-version.ads
@@ -30,17 +30,17 @@
 
 package GPR.Version is
 
-   Gpr_Version : constant String := "18.0w";
+   Gpr_Version : constant String := "24.0.1";
    --  Static string identifying this version
 
-   Date : constant String := "19940713";
+   Date : constant String := "20240409";
 
-   Current_Year : constant String := "2016";
+   Current_Year : constant String := "2024";
 
    type Gnat_Build_Type is (Gnatpro, FSF, GPL);
    --  See Get_Gnat_Build_Type below for the meaning of these values
 
-   Build_Type : constant Gnat_Build_Type := Gnatpro;
+   Build_Type : constant Gnat_Build_Type := FSF;
    --  Kind of GNAT Build:
    --
    --    FSF
```

and (see [gprbuild issue 141](https://github.com/AdaCore/gprbuild/issues/141))

```
diff --git a/src/gprlib.adb b/src/gprlib.adb
index aaec038e..edc74f13 100644
--- a/src/gprlib.adb
+++ b/src/gprlib.adb
@@ -875,7 +875,7 @@ procedure Gprlib is
          if Separate_Run_Path_Options then
             for J in 1 .. Rpath.Last_Index loop
                Options_Table.Append
-                 (Concat_Paths (Path_Option, " ") & ' ' & Rpath (J));
+                 (Concat_Paths (Path_Option, " ") & Rpath (J));
             end loop;
 
          else
```

#### Libadalang Tools ####

```
diff --git a/src/utils-versions.ads b/src/utils-versions.ads
index 11ebb13a..a1fba976 100644
--- a/src/utils-versions.ads
+++ b/src/utils-versions.ads
@@ -23,12 +23,12 @@
 
 package Utils.Versions is
 
-   Version      : constant String := "dev";
-   Current_Year : constant String := "unknown";
+   Version      : constant String := "24.0.0";
+   Current_Year : constant String := "2024";
 
    type Gnat_Build_Type is (Gnatpro, GPL);
 
-   Build_Type : constant Gnat_Build_Type := Gnatpro;
+   Build_Type : constant Gnat_Build_Type := GPL;
    --  Kind of GNAT Build:
    --
    --    Gnatpro
```

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

### Include, library paths ###

As noted [here][SDKS], Apple have changed the location of system include files and libraries; they used to be copied from the SDKs to the "standard" `/usr/include` and `/usr/lib` either automatically or on command.

This compiler has been built so you don't need to take any related action to use it: unfortunately, this means that paths in `/usr/local` and `/Library/Frameworks` aren't searched.

[SDKS]: https://forward-in-code.blogspot.com/2022/03/which-sdk-choices-choices.html
