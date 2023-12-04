# Build and install gprconfig & gprbuild (but not libgpr) for use in
# Alire, using an existing compiler on PATH.

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

# build next to gcc
GPRBUILD_PREFIX=$PREFIX/../gprbuild

# Install gprconfig first.

gprconfig_install_loc=$GPRBUILD_PREFIX/share/gprconfig

mkdir -p $gprconfig_install_loc

cp -p $GPRCONFIG_SRC/db/* $gprconfig_install_loc/

rm -rf *

# We're going to use our own xmlada.gpr (we can't use the one that
# xmlada would install with the compiler, because it's an aggregate;
# we only want a static build anyway).
GPR_PROJECT_PATH=$script_loc
# That xmlada.gpr needs $XMLADA_SRC, but it's only a local variable so
# far because common.sh is sourced.
export XMLADA_SRC

echo "*** cleaning ***"
make -w -f $GPRBUILD_SRC/Makefile               \
     TARGET=$BUILD                              \
     ENABLE_SHARED=yes                          \
     clean || true

echo "*** setting up ***"
make -w -f $GPRBUILD_SRC/Makefile               \
     GPR_PROJECT_PATH=$GPR_PROJECT_PATH         \
     TARGET=$BUILD                              \
     ENABLE_SHARED=yes                          \
     setup

echo "*** building ***"
make -w -j7                                     \
     -f $GPRBUILD_SRC/Makefile                  \
     GPR_PROJECT_PATH=$GPR_PROJECT_PATH         \
     all

echo "*** installing ***"
make -w                                         \
     -f $GPRBUILD_SRC/Makefile                  \
     GPR_PROJECT_PATH=$GPR_PROJECT_PATH         \
     prefix=$GPRBUILD_PREFIX                    \
     install

# Remove the highly-misleading script installed in the top-level directory.
rm -f $GPRBUILD_PREFIX/doinstall
