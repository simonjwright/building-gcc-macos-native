This is GCC 12.2.0 built on Mac OS X El Capitan (10.11, Darwin 15), with Xcode 8.2.1 and Python 3.9.8.

Also runs on macOS versions up to at least Monterey (12, Darwin 21). It will run on Intel Macs, or M1 Macs under Rosetta, and uses the Xcode SDK if found, the Command Line Tooks SDK if not.

**gcc-12.2.0-x86_64-apple-darwin15.pkg**

Compilers included: Ada, C, C++.

Tools included (all at version 23.0.0, and all with the  [Runtime Library Exception][RLE], except as noted):

Full GPL:

* <a name="gdb-build"></a> GDB from https://sourceware.org/git/binutils-gdb.git at tag `gdb-12.1-release`, **without Python support**).

GPL with the [Runtime Library Exception][RLE]:

* AUnit from https://github.com/AdaCore/aunit
* GNATCOLL from:
  * https://github.com/AdaCore/gnatcoll-core
  * https://github.com/AdaCore/gnatcoll-bindings (ZLIB is included, OMP and LZMA are not (the GNATCOLL version for LZMA requires thread support in the system library, not available on macOS))
  * https://github.com/AdaCore/gnatcoll-db (only the SQLite backend)
* Gprbuild from https://github.com/AdaCore/gprbuild
* Langkit from https://github.com/AdaCore/langkit
* Libadalang from https://github.com/AdaCore/libadalang
* Libadalang tools from https://github.com/AdaCore/libadalang-tools
* Templates parser from https://github.com/AdaCore/templates-parser
* XMLAda from https://github.com/AdaCore/xmlada

Configured with:
```
--prefix=/opt/gcc-12.2.0
--without-libiconv-prefix 
--disable-libmudflap 
--disable-libstdcxx-pch 
--disable-libsanitizer 
--disable-libcc1 
--disable-libcilkrts 
--disable-multilib 
--disable-nls 
--enable-languages=c,c++,ada 
--host=x86_64-apple-darwin15 
--target=x86_64-apple-darwin15 
--build=x86_64-apple-darwin15 
--without-isl 
--with-build-sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk 
--with-sysroot= 
--with-specs='%{!sysroot=*:
--sysroot=%:if-exists-else(/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk)}' 
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

`PATH` needs to be set to include `/opt/gcc-12.2.0/bin` at the front:

#### `bash` ####

Insert
```
export PATH=/opt/gcc-12.2.0/bin:$PATH
```
in your `~/.bash_profile_common`.

#### `zsh` ####

Likewise, but in `~/.zshrc`.

See [here][ZSH] for helpful information on moving to `zsh`.

[ZSH]: https://scriptingosx.com/2019/06/moving-to-zsh/

### <a name="installing-gdb">Installing GDB</a> ###

`gdb` has to be 'code-signed' (unless you're willing to run it as root!) and under Sierra and later macOS releases there are additional steps that have to be taken.

For El Capitan, see [here][CS-ELC].

For Sierra, and High Sierra, see [here][CS-SIERRA]; in the case of High Sierra, the 10.12.1 paragraph refers.

For Mojave, Catalina, Big Sur and Monterey, see [here][CS-MOJAVE].

[CS-ELC]: https://gcc.gnu.org/onlinedocs/gnat_ugn/Codesigning-the-Debugger.html
[CS-SIERRA]: http://blog.adacore.com/gnat-on-macos-sierra
[CS-MOJAVE]: https://forward-in-code.blogspot.com/2018/11/mojave-vs-gdb.html

## Notes ##

The software was built using the [building-gcc-macos-native][BUILDING] scripts at Github, tag gcc-12.2.0.

[BUILDING]:https://github.com/simonjwright/building-gcc-macos-native

### Compiler ###

The compiler is GPL version 3. The runtime has the GCC Runtime Exception, so executables built with it can be released on proprietary terms.

### GMP, MPFR, MPC ###

These libraries (releases 6.2.1, 4.1.0, 1.2.1 respectively) are installed with the compiler.

### Include, library paths ###

As noted [here][SDKS], Apple have changed the location of system include files and libraries; they used to be copied from the SDKs to the "standard" `/usr/include` and `/usr/lib` either automatically or on command.

This compiler has been built so you don't need to take any related action to use it: unfortunately, this means that paths in `/usr/local` and `/Library/Frameworks` aren't searched.

[SDKS]: https://forward-in-code.blogspot.com/2022/03/which-sdk-choices-choices.html

## Distribution ##

The distribution was prepared using the [distributing-gcc project][DIST] at Github, tag gcc-12.2.0-x86_64.

[DIST]: https://github.com/simonjwright/distributing-gcc
