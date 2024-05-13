# Ensure the GCC source tree already has required versions of GMP,
# MPFR, MPC installed via contrib/download_prerequisites.

set -eu

VERSION=${VERSION:=14.1.0}
BUILD=$ARCH-apple-darwin21
BOOTSTRAP=${BOOTSTRAP:=enable}   # or disable

PYTHON=python3.9
CORES=$(sysctl -n hw.ncpu)

# Exported so GCC sees it while compiling/linking: Monterey
export MACOSX_DEPLOYMENT_TARGET=12

# Everything is under this directory (it's an external USB disk, named
# Miscellaneous3). I do the builds on this disk, too, with the thought
# that it should reduce wear on the system disk.
TOP=/Volumes/Miscellaneous3

######################################################################
# Where's the build going to be targeted?
# There are various possibilities, which, if set, will override the
# default.

# Override the default version if necessary
# PREFIX=/opt/gcc-$VERSION-20232226-$ARCH

# For gcc-for-alire, gprbuild-for-alire
# PREFIX=$TOP/alire-$ARCH/gcc

# To keep the build away from the eventual target (this assumes the
# code is relocatable! which, now, it is.
PREFIX=$TOP/$ARCH/gcc-$VERSION-$ARCH

# The default version (e.g. /opt-gcc-13.2.0-x86_64) is overridable.
PREFIX=${PREFIX:-/opt/gcc-$VERSION-$ARCH}
######################################################################

######################################################################
# Where is the source stored?

#This assumes that all the source has been extracted under the one
# directory.
SRC_PATH=$TOP/src

#---------------------------------------------------------------------
# GCC source; there are lots of compiler options.

# Building gcc-mirror
# GCC_SRC=$SRC_PATH/gcc

# Building gcc-13 for aarch64; the actual tag in that clone is
# gcc-13-3-darwin-pre-0 !!!
# GCC_SRC=$SRC_PATH/gcc-13-branch

# Building gcc-14 for aarch64; the actual tag in that clone is
# gcc-14.1-darwin-r0.
GCC_SRC=$SRC_PATH/gcc-14-branch

# Building iains's WIP for aarch64
# GCC_SRC=$SRC_PATH/gcc-darwin-arm64

# Building the latest FSF snapshot
# SNAPSHOT=20240407
# GCC_SRC=$SRC_PATH/gcc-14-$SNAPSHOT

# The default for an FSF releaase
GCC_SRC=${GCC_SRC:-$SRC_PATH/gcc-$VERSION}
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Pick up the new compiler for building all the other components
NEW_PATH=$PREFIX/bin:$PATH
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Where all the other component sources are to be found. I use Git
# clones mostly, in case I need to patch them, but you may prefer to
# use releases. As an example, gnatcoll-db's 23.0.0 release unpacks to
# gnatcoll-db-23.0.0/, whereas a clone would naturally unpack to just
# gnatcoll-db/ as below.
ADASAT_SRC=$SRC_PATH/AdaSAT
AUNIT_SRC=$SRC_PATH/aunit
GDB_SRC=$SRC_PATH/binutils-gdb
GNATCOLL_BINDINGS_SRC=$SRC_PATH/gnatcoll-bindings
GNATCOLL_CORE_SRC=$SRC_PATH/gnatcoll-core
GNATCOLL_DB_SRC=$SRC_PATH/gnatcoll-db
GPR2_SRC=$SRC_PATH/gpr
GPRBUILD_SRC=$SRC_PATH/gprbuild
GPRCONFIG_SRC=$SRC_PATH/gprconfig_kb
LANGKIT_SRC=$SRC_PATH/langkit
LIBADALANG_SRC=$SRC_PATH/libadalang
LIBADALANG_TOOLS_SRC=$SRC_PATH/libadalang-tools
TEMPLATES_PARSER_SRC=$SRC_PATH/templates-parser
VSS_SRC=$SRC_PATH/VSS
XMLADA_SRC=$SRC_PATH/xmlada
#---------------------------------------------------------------------

######################################################################
