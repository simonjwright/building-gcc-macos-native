# Build using extant GCC.

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

XCODE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
CLT=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk

SDKROOT=$(xcrun --show-sdk-path)
SHIM=/usr/local/bin/ld-shim

echo "BUILDING THE COMPILER IN $PREFIX"

set -eu
rm -rf *

$GCC_SRC/configure                                                       \
    --prefix=$PREFIX                                                     \
    --without-libiconv-prefix                                            \
    --disable-libgomp                                                    \
    --disable-libmudflap                                                 \
    --disable-libstdcxx-pch                                              \
    --disable-libsanitizer                                               \
    --disable-libcc1                                                     \
    --disable-libcilkrts                                                 \
    --disable-multilib                                                   \
    --disable-nls                                                        \
    --enable-languages=c,c++,ada                                         \
    --host=$BUILD                                                        \
    --target=$BUILD                                                      \
    --build=$BUILD                                                       \
    --without-isl                                                        \
    --with-build-sysroot=$SDKROOT                                        \
    --with-sysroot=                                                      \
    --with-specs="%{!sysroot=*:--sysroot=%:if-exists-else($XCODE $CLT)}" \
    --$BOOTSTRAP-bootstrap                                               \
    --enable-host-pie                                                    \
    CFLAGS=-Wno-deprecated-declarations                                  \
    CXXFLAGS=-Wno-deprecated-declarations

#  --with-ld=$SHIM                                                      \
#

make -w -j7

make -w -j7 install
