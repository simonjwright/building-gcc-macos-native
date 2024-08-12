script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

rm -rf *

$GCC_SRC/mpfr/configure                         \
  --prefix=$PREFIX                              \
  --host=$BUILD                                 \
  --target=$BUILD                               \
  --build=$BUILD                                \
  --with-gmp=$PREFIX                            \
  --enable-shared

make -w -j3

make install
