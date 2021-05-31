script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

$GCC_SRC/configure                                      \
  --prefix=$PREFIX                                      \
  --without-libiconv-prefix                             \
  --disable-libmudflap                                  \
  --disable-libstdcxx-pch                               \
  --disable-libsanitizer                                \
  --disable-libcc1                                      \
  --disable-libcilkrts                                  \
  --disable-multilib                                    \
  --disable-nls                                         \
  --enable-languages=c,ada                              \
  --host=$BUILD                                         \
  --target=$BUILD                                       \
  --build=$BUILD                                        \
  --with-boot-ldflags="$GCC_BOOT_LDFLAGS"               \
  --with-stage1-ldflags="$GCC_STAGE1_LDFLAGS"           \
  --enable-lto                                          \
  --with-build-config=no                                \
  --with-build-sysroot=${SDKROOT}                       \
  --with-sysroot=                                       \
  --with-specs='%{!sysroot=*:--sysroot=${SDKROOT}}'

make -w -j3

make install

# need gmp for gnatcoll-bindings
make -C gmp install
