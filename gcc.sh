# Build using extant GCC.

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

XCODE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
CLT=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk

SDKROOT=$(xcrun --show-sdk-path)
BUGURL=https://github.com/simonjwright/building-gcc-macos-native

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
    --disable-libgomp                                                    \
    --enable-languages=c,c++,ada                                         \
    --host=$BUILD                                                        \
    --target=$BUILD                                                      \
    --build=$BUILD                                                       \
    --without-isl                                                        \
    --with-build-sysroot=$SDKROOT                                        \
    --with-sysroot=                                                      \
    --with-specs="%{!sysroot=*:--sysroot=%:if-exists-else($XCODE $CLT)}" \
    --with-bugurl=$BUGURL                                                \
    --$BOOTSTRAP-bootstrap                                               \
    --enable-host-pie                                                    \
    CFLAGS=-Wno-deprecated-declarations                                  \
    CXXFLAGS=-Wno-deprecated-declarations

make -w -j$CORES

make -w -j$CORES install

for exe in $PREFIX/bin/*; do
    if [[ $(file $exe) == *executable* ]]; then
        bash $script_loc/fix_executable_rpaths.sh $exe
    fi
done

for lib in $PREFIX/lib/*.dylib; do
    if [[ $(file $lib) == *shared\ library* ]]; then
        bash $script_loc/fix_library_rpaths.sh $lib
    fi
done

