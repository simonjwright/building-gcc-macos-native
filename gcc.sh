# Build using extant GCC.

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

XCODE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.sdk
CLT=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk

BUGURL=https://github.com/simonjwright/building-gcc-macos-native

echo "BUILDING THE COMPILER IN $PREFIX"

set -eu
rm -rf *

BASE_COMPILER=/Volumes/Miscellaneous3/x86_64/gcc-14.2.0-clt-x86_64
BASE_SYSROOT=/Library/Developer/CommandLineTools-14.3/SDKs/MacOSX13.sdk

$GCC_SRC/configure                                                      \
    --prefix=$PREFIX                                                    \
    --enable-languages=c,c++,ada                                        \
    --build=$BUILD                                                      \
    --with-sysroot=$SDKROOT/../MacOSX14.sdk                             \
    --with-specs="%{!-sysroot:--sysroot=%:if-exists-else($XCODE $CLT)}" \
    --with-bugurl=$BUGURL                                               \
    --$BOOTSTRAP-bootstrap                                              \
    CC="$BASE_COMPILER/bin/gcc --sysroot=$BASE_SYSROOT"                 \
    CXX="$BASE_COMPILER/bin/g++ --sysroot=$BASE_SYSROOT"

make -w -j$CORES

make -w -j$CORES install
