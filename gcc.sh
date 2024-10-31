# Build using extant GCC.

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

XCODE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.sdk
CLT=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk

BUGURL=https://github.com/simonjwright/building-gcc-macos-native

echo "BUILDING THE COMPILER IN $PREFIX"

set -eu
rm -rf *

$GCC_SRC/configure                                                      \
    --prefix=$PREFIX                                                    \
    --enable-languages=c,c++,ada                                        \
    --build=$BUILD                                                      \
    --with-sysroot=$SDKROOT/../MacOSX14.sdk                             \
    --with-specs="%{!-sysroot:--sysroot=%:if-exists-else($XCODE $CLT)}" \
    --with-bugurl=$BUGURL                                               \
    --$BOOTSTRAP-bootstrap                                              \
    CC="/Volumes/Miscellaneous3/aarch64/gcc-14.2.0-clt15-aarch64/bin/gcc --sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk" \
    CXX="/Volumes/Miscellaneous3/aarch64/gcc-14.2.0-clt15-aarch64/bin/g++ --sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk"

make -w -j$CORES

make -w -j$CORES install
