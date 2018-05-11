script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

make -f $GNATCOLL_CORE_SRC/Makefile             \
     prefix=$PREFIX                             \
     ENABLE_SHARED=yes                          \
     setup

make -w                                         \
     GPRBUILD_OPTIONS="--db $script_loc/config" \
     -f $GNATCOLL_CORE_SRC/Makefile

make -w                                         \
     GPRBUILD_OPTIONS="--db $script_loc/config" \
     -f $GNATCOLL_CORE_SRC/Makefile             \
     install
