script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

make -f $GPRBUILD_SRC/Makefile ENABLE_SHARED=yes setup

make -w -j3 GPRBUILD_OPTIONS="--db $script_loc/config"  \
     -f $GPRBUILD_SRC/Makefile                          \
     all                                                \
     libgpr.build

make -w GPRBUILD_OPTIONS="--db $script_loc/config"      \
     -f $GPRBUILD_SRC/Makefile                          \
     install                                            \
     libgpr.install
