set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

$GDB_PATH/configure                             \
    --build=$BUILD                              \
    --prefix=$PREFIX                            \
    --with-python=no                            \
    --disable-werror

make -w all -j3

cd gdb
make install
