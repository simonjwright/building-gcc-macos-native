script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

make -w -j3                                             \
     -C $GNAT_UTIL_SRC                                  \
     BASE=$TOP                                          \
     RELEASE=$VERSION                                   \
     GCC_BLD_BASE=$SRC_PATH/x86_64/gcc-$VERSION-build   \
     GPRBUILD_OPTIONS="--db $script_loc/config"         \
     all

make -w                                                 \
     -C $GNAT_UTIL_SRC                                  \
     BASE=$TOP                                          \
     RELEASE=$VERSION                                   \
     GCC_BLD_BASE=$SRC_PATH/x86_64/gcc-$VERSION-build   \
     GPRBUILD_OPTIONS="--db $script_loc/config"         \
     install
