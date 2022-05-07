# If the argument is 'cross', build the cross-compiler.
# if not, use the cross-compiler to build the real compiler.

arg="$1"

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

XCODE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
CLU=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk

SDKROOT=$(xcrun --show-sdk-path)
X86=x86_64-apple-darwin21
ARM=aarch64-apple-darwin21

XPREFIX=~/tmp/aarch64-apple-darwin-cross-8

[ "x$arg" == xcross ]  && (
    set -eu
    echo "BUILDING THE CROSS-COMPILER IN $XPREFIX"
    [ -d cross ] || mkdir cross
    cd cross
    $GCC_SRC/configure                          \
        --prefix=$XPREFIX                       \
        --program-prefix=                       \
        --without-libiconv-prefix               \
        --disable-libmudflap                    \
        --disable-libstdcxx-pch                 \
        --disable-libsanitizer                  \
        --disable-libcc1                        \
        --disable-libcilkrts                    \
        --disable-multilib                      \
        --disable-nls                           \
        --enable-languages=c,c++,ada            \
        --target=$ARM                           \
        --build=$X86                            \
        --without-isl                           \
        --with-sysroot=$SDKROOT                 \
        --with-as=/usr/bin/as                   \
        --with-ld=/usr/bin/ld                   \
        --with-ranlib=/usr/bin/ranlib           \
        --with-dsymutil=/usr/bin/dsymutil       \
        --with-build-config=no                  \
        --disable-bootstrap                     \
        AR_FOR_TARGET=/usr/bin/ar               \
        AS_FOR_TARGET=/usr/bin/as               \
        DSYMUTIL_FOR_TARGET=/usr/bin/dsymutil   \
        LD_FOR_TARGET=/usr/bin/ld               \
        LIPO_FOR_TARGET=/usr/bin/lipo           \
        NM_FOR_TARGET=/usr/bin/nm               \
        OBJDUMP_FOR_TARGET=/usr/bin/objdump     \
        OTOOL_FOR_TARGET=/usr/bin/otool         \
        RANLIB_FOR_TARGET=/usr/bin/ranlib       \
        STRIP_FOR_TARGET=/usr/bin/strip
    
    make -w -j7

    make -w -j7 install

    exit
)

echo "BUILDING THE COMPILER IN $PREFIX"

(
    set -eu
    [ -d native ] || mkdir native
    cd native
    rm -rf *
    
    PATH=$XPREFIX/bin:$PATH

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
        --host=$ARM                                                          \
        --target=$ARM                                                        \
        --build=$ARM                                                         \
        --without-isl                                                        \
        --with-build-sysroot=$SDKROOT                                        \
        --with-sysroot=                                                      \
        --with-specs="%{!sysroot=*:--sysroot=%:if-exists-else($XCODE $CLU)}" \
        --with-as=/usr/bin/as                                                \
        --with-ld=/usr/bin/ld                                                \
        --with-ranlib=/usr/bin/ranlib                                        \
        --with-dsymutil=/usr/bin/dsymutil                                    \
        --with-build-config=no                                               \
        --disable-bootstrap
    
    make -w -j7

    make -w -j7 install
)
