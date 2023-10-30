script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

rm -rf *

echo "*** cleaning ***"
make -w -f $GPRBUILD_SRC/Makefile               \
     TARGET=$BUILD                              \
     ENABLE_SHARED=yes                          \
     clean || true  # otherwise, fail because there's no Fortran

echo "*** setting up ***"
make -w -f $GPRBUILD_SRC/Makefile               \
     TARGET=$BUILD                              \
     ENABLE_SHARED=yes                          \
     setup

echo "*** building ***"
make -w -j7                                     \
     -f $GPRBUILD_SRC/Makefile                  \
     all

echo "*** building libgpr ***"
make -w -j7                                     \
     -f $GPRBUILD_SRC/Makefile                  \
     libgpr.build

echo "*** installing ***"
make -w                                         \
     -f $GPRBUILD_SRC/Makefile                  \
     install

echo "*** installing libgpr ***"
make -w                                         \
     -f $GPRBUILD_SRC/Makefile                  \
     libgpr.install

# Remove the highly-misleading script installed in the top-level directory.
rm -f $PREFIX/doinstall
