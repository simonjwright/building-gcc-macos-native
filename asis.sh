script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

make -w                                         \
     -C $ASIS_SRC                               \
     GPRBUILD_FLAGS="--db $script_loc/config"   \
     all tools

make -w                                         \
     -C $ASIS_SRC                               \
     GPRBUILD_FLAGS="--db $script_loc/config"   \
     install install-tools
