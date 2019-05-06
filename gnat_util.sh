script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

make -w -j3                                     \
     -C $GNAT_UTIL_SRC                          \
     BASE=$TOP                                  \
     RELEASE=$VERSION                           \
     GCC_SRC_BASE=$GCC_SRC                      \
     GCC_BLD_BASE=$GCC_BLD                      \
     GPRBUILD_OPTIONS="--db $script_loc/config" \
     clean all

make -w                                         \
     -C $GNAT_UTIL_SRC                          \
     BASE=$TOP                                  \
     RELEASE=$VERSION                           \
     GCC_SRC_BASE=$GCC_SRC                      \
     GCC_BLD_BASE=$GCC_BLD                      \
     GPRBUILD_OPTIONS="--db $script_loc/config" \
     install
