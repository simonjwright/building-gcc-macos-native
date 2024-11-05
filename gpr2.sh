set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

make -f $GPR2_SRC/Makefile                      \
     prefix=$PREFIX                             \
     ENABLE_SHARED=yes                          \
     GPR2_BUILD=release                         \
     PROCESSORS=0                               \
     PROFILER=no                                \
     LOCAL_GPR2=yes                             \
     GPR2KBDIR=$GPRCONFIG_SRC/db                \
     setup

make -w -j$CORES -f $GPR2_SRC/Makefile build-libs

make -w -f $GPR2_SRC/Makefile install-libs
