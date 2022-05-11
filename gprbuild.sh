set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

make -f $GPRBUILD_SRC/Makefile ENABLE_SHARED=yes setup

make -w                                         \
     -f $GPRBUILD_SRC/Makefile                  \
     all                                        \
     libgpr.build

make -w                                         \
     -f $GPRBUILD_SRC/Makefile                  \
     install                                    \
     libgpr.install

# Remove the highly-misleading script installed in the top-level directory.
rm -f $PREFIX/doinstall
