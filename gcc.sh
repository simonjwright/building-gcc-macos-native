# Build using extant GCC for x86_64-apple-darwin.

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

XCODE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
CLU=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk

SDKROOT=$(xcrun --show-sdk-path)
X86=x86_64-apple-darwin21
ARM=aarch64-apple-darwin21

echo "BUILDING THE COMPILER IN $PREFIX"

set -eu
rm -rf *

$GCC_SRC/configure                                                       \
    --prefix=$PREFIX                                                     \
    --without-libiconv-prefix                                            \
    --disable-libmudflap                                                 \
    --disable-libstdcxx-pch                                              \
    --disable-libsanitizer                                               \
    --disable-libcc1                                                     \
    --disable-libcilkrts                                                 \
    --disable-multilib                                                   \
    --disable-nls                                                        \
    --enable-languages=c,c++,ada                                         \
    --host=$X86                                                          \
    --target=$X86                                                        \
    --build=$X86                                                         \
    --without-isl                                                        \
    --with-build-sysroot=$SDKROOT                                        \
    --with-sysroot=                                                      \
    --with-specs="%{!sysroot=*:--sysroot=%:if-exists-else($XCODE $CLU)}" \
    --with-as=/usr/bin/as                                                \
    --with-ld=/usr/bin/ld                                                \
    --with-ranlib=/usr/bin/ranlib                                        \
    --with-dsymutil=/usr/bin/dsymutil                                    \
    --disable-bootstrap                                                   \
    --enable-host-pie                                                    \
    CFLAGS=-Wno-deprecated-declarations                                  \
    CXXFLAGS=-Wno-deprecated-declarations

make -w -j7

make -w -j7 install
