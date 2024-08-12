script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

$GDB_SRC/configure                             \
 --build=$BUILD                                 \
 --prefix=$PREFIX                               \
 --disable-werror

make -w all -j$CORES

cd gdb
make install
