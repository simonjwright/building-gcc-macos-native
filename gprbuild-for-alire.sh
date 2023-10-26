# Build and install gprconfig & gprbuild (but not libgpr) for use in Alire

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

GPRBUILD_PREFIX=$TOP/alire-aarch64/gprbuild

# Install gprconfig first.

gprconfig_install_loc=$GPRBUILD_PREFIX/share/gprconfig

mkdir -p $gprconfig_install_loc

cp -p $GPRCONFIG_SRC/db/* $gprconfig_install_loc/

rm -rf *

echo "*** cleaning ***"
make -w -f $GPRBUILD_SRC/Makefile               \
     TARGET=$BUILD                              \
     ENABLE_SHARED=yes                          \
     clean

echo "*** setting up ***"
make -w -f $GPRBUILD_SRC/Makefile               \
     TARGET=$BUILD                              \
     ENABLE_SHARED=yes                          \
     setup

echo "*** building ***"
make -w -j7                                     \
     -f $GPRBUILD_SRC/Makefile                  \
     all

echo "*** installing ***"
make -w                                         \
     -f $GPRBUILD_SRC/Makefile                  \
     prefix=$GPRBUILD_PREFIX                    \
     install

# Remove the highly-misleading script installed in the top-level directory.
rm -f $GPRBUILD_PREFIX/doinstall
