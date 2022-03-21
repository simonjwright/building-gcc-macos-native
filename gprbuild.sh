script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

rm -rf *

make -f $GPRBUILD_SRC/Makefile                  \
     TARGET=$BUILD                              \
     ENABLE_SHARED=yes                          \
     setup

make -w -j7                                     \
     -f $GPRBUILD_SRC/Makefile                  \
     all

make -w -j7                                     \
     -f $GPRBUILD_SRC/Makefile                  \
     libgpr.build

make -w                                         \
     -f $GPRBUILD_SRC/Makefile                  \
     install

make -w                                         \
     -f $GPRBUILD_SRC/Makefile                  \
     libgpr.install

# Remove the highly-misleading script installed in the top-level directory.
rm -f $PREFIX/doinstall
