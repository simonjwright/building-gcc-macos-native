# Build and install gprconfig & gprbuild (but not libgpr) for use in
# Alire, using an existing compiler on PATH.

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

# Build next to gcc.
# The Alire-downloadable archive needs to have gprbuild/ as its top level.
GPRBUILD_PREFIX=$PREFIX/../gprbuild

# Install gprconfig first.

gprconfig_install_loc=$GPRBUILD_PREFIX/share/gprconfig

mkdir -p $gprconfig_install_loc

cp -p $GPRCONFIG_SRC/db/* $gprconfig_install_loc/

rm -rf *

# Use the compiler we've already built.
PATH=$NEW_PATH

echo "*** cleaning ***"
make -w -f $GPRBUILD_SRC/Makefile               \
     TARGET=$BUILD                              \
     ENABLE_SHARED=no                           \
     clean || true  # otherwise, fail because there's no Fortran

echo "*** setting up ***"
make -w -f $GPRBUILD_SRC/Makefile               \
     TARGET=$BUILD                              \
     ENABLE_SHARED=no                           \
     setup

echo "*** building ***"
make -w -j$CORES                                \
     -f $GPRBUILD_SRC/Makefile                  \
     all

echo "*** installing ***"
make -w                                         \
     -f $GPRBUILD_SRC/Makefile                  \
     prefix=$GPRBUILD_PREFIX                    \
     install

# Remove the highly-misleading script installed in the top-level directory.
rm -f $GPRBUILD_PREFIX/doinstall
