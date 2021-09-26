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
  --enable-languages=c,c++,ada,fortran,objc,obj-c++     \
  --host=$BUILD                                         \
  --target=$BUILD                                       \
  --build=$BUILD                                        \
  --without-isl                                         \
  --with-build-sysroot="$SDKROOT"                       \
  --with-sysroot=                                       \
  --with-specs="%{!sysroot=*:--sysroot=$SDKROOT}"       \
  --with-build-config=no                                \
  --enable-bootstrap

make -w -j3

make install
