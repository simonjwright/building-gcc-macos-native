script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

cd $XMLADA_SRC

./configure                                     \
  --prefix=$PREFIX                              \
  --host=$BUILD                                 \
  --target=$BUILD                               \
  --build=$BUILD                                \
  --enable-shared

make -w -j3 GPRBUILD_OPTIONS="--db $script_loc/config"

make install
