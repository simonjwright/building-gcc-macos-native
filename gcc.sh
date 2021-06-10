script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

$GCC_SRC/configure                              \
  --prefix=$PREFIX                              \
  --without-libiconv-prefix                     \
  --disable-libmudflap                          \
  --disable-libstdcxx-pch                       \
  --disable-libsanitizer                        \
  --disable-libcc1                              \
  --disable-libcilkrts                          \
  --disable-multilib                            \
  --disable-nls                                 \
  --enable-languages=c,c++,ada                  \
  --host=$BUILD                                 \
  --target=$BUILD                               \
  --build=$BUILD                                \
  --with-gmp=$PREFIX                            \
  --with-mpfr=$PREFIX                           \
  --with-mpc=$PREFIX                            \
  --without-isl                                 \
  --with-boot-ldflags="$GCC_BOOT_LDFLAGS"       \
  --with-stage1-ldflags="$GCC_STAGE1_LDFLAGS"   \
  --with-build-sysroot="$SDKROOT"               \
  --with-sysroot=                               \
  --with-build-config=no

make -w -j4

make install
