This is GCC 14.2.0 built on macOS Sonoma (14, Darwin 23) for Apple silicon, with Command Line Utilities 15.3.0 and Python 3.9.13.

It will also run on Sequoia (15, Darwin24) and with Xcode/Command Line Tools 16, **but it will not run on Monterey**.

Compilers included: Ada, C, C++.

Compiler sources are from https://github.com/iains/gcc-14-branch at tag `gcc-14.2-darwin-r2`.
 
Tools included (all at version 25.0.0, and all with the  [Runtime Library Exception][RLE]):

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
* Prettier-Ada from https://github.com/AdaCore/prettier-ada
* Templates Parser from  https://github.com/AdaCore/templates-parser
* VSS from https://github.com/AdaCore/VSS
* XMLAda from https://github.com/AdaCore/xmlada

Configured with:
```
--prefix=/Volumes/Miscellaneous3/aarch64/gcc-14.2.0-3-aarch64
--enable-languages=c,c++,ada
--build=aarch64-apple-darwin23
--with-sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/../MacOSX14.sdk
--with-specs='%{!-sysroot:--sysroot=%:if-exists-else(/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.sdk /Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk)}'
--with-bugurl=https://github.com/simonjwright/building-gcc-macos-native
--enable-bootstrap
```

[RLE]: http://www.gnu.org/licenses/gcc-exception-faq.html

## Installation, setting PATH ##

Please see the [Wiki](https://github.com/simonjwright/distributing-gcc/wiki).

## Notes ##

The software was built using the [building-gcc-macos-native][BUILDING] scripts at Github, tag `gcc-14.2.0-3-aarch64`.

All compilations were done with `export MACOSX_DEPLOYMENT_TARGET=14` so that libraries and executables are compatible with macOS Sonoma and later.

[BUILDING]:https://github.com/simonjwright/building-gcc-macos-native

### Compiler ###

The compiler is GPL version 3. The runtime has the GCC Runtime Exception, so executables built with it can be released on proprietary terms.

### GMP ###

This library (release 6.2.1) is installed with the compiler.

### Other sources ###

The necessary patches to the v25.0.0 tools are included in the release in the file `gcc-14.2.0-3-patches.zip`.

### Include, library paths ###

As noted [here][SDKS], Apple have changed the location of system include files and libraries; they used to be copied from the SDKs to the "standard" `/usr/include` and `/usr/lib` either automatically or on command.

This compiler has been built so you don't need to take any related action to use it: unfortunately, this means that paths in `/usr/local` and `/Library/Frameworks` aren't searched.

[SDKS]: https://forward-in-code.blogspot.com/2022/03/which-sdk-choices-choices.html
