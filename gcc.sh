set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

XCODE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
CLU=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk

$GCC_SRC/configure                                                      \
  --prefix=$PREFIX                                                      \
  --without-libiconv-prefix                                             \
  --disable-libmudflap                                                  \
  --disable-libstdcxx-pch                                               \
  --disable-libsanitizer                                                \
  --disable-libcc1                                                      \
  --disable-libcilkrts                                                  \
  --disable-multilib                                                    \
  --disable-nls                                                         \
  --enable-languages=c,c++,ada                                          \
  --host=$BUILD                                                         \
  --target=$BUILD                                                       \
  --build=$BUILD                                                        \
  --without-isl                                                         \
  --with-build-sysroot="$(xcrun --show-sdk-path)"                       \
  --with-sysroot=                                                       \
  --with-specs="%{!sysroot=*:--sysroot=%:if-exists-else($XCODE $CLU)}"  \
  --with-build-config=no                                                \
  --enable-bootstrap

make -w -j7

make install
