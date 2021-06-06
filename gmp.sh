script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

$GCC_SRC/gmp/configure                          \
  --prefix=$PREFIX                              \
  --host=$BUILD                                 \
  --target=$BUILD                               \
  --build=$BUILD                                \
  --enable-shared

make -w -j4

make install
