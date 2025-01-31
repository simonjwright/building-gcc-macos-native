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
    --prefix=$PREFIX/gcc                                                \
    --enable-languages=c,c++,ada                                        \
    --build=$BUILD                                                      \
    --with-sysroot=$SDKROOT/../MacOSX14.sdk                             \
    --with-specs="%{!-sysroot:--sysroot=%:if-exists-else($XCODE $CLT)}" \
    --with-bugurl=$BUGURL                                               \
    --$BOOTSTRAP-bootstrap

    # CFLAGS=-Wno-deprecated-declarations                                  \
    # CXXFLAGS=-Wno-deprecated-declarations

make -w -j$CORES

make -w -j$CORES install
