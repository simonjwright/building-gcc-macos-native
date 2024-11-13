# Build using extant GCC.

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

BUGURL=https://github.com/simonjwright/building-gcc-macos-native

echo "BUILDING THE COMPILER IN $PREFIX"

set -eu
rm -rf *

$GCC_SRC/configure                              \
    --prefix=$PREFIX                            \
    --enable-languages=c,c++,ada                \
    --with-sysroot=$SDKROOT                     \
    --build=$BUILD                              \
    --with-bugurl=$BUGURL                       \
    --$BOOTSTRAP-bootstrap

make -w -j$CORES

make -w -j$CORES install
