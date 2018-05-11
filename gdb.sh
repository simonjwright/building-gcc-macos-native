script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

$GDB_PATH/configure                             \
 --build=$BUILD                                 \
 --prefix=$PREFIX                               \
 --disable-werror

make -w all -j3

cd gdb
make install
