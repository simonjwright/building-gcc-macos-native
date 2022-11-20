script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

cd $XMLADA_SRC

make distclean || true

./configure                                     \
  --prefix=$PREFIX                              \
  --target=$BUILD                               \
  --enable-shared                               \
  PACKAGE_VERSION=v23.0.0

make -w -j7

make -w install
