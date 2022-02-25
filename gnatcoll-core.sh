script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

make -f $GNATCOLL_CORE_SRC/Makefile             \
     prefix=$PREFIX                             \
     ENABLE_SHARED=yes                          \
     setup

make -w                                         \
     -f $GNATCOLL_CORE_SRC/Makefile

make -w                                         \
     -f $GNATCOLL_CORE_SRC/Makefile             \
     install
