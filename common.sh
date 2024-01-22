# Ensure the GCC source tree already has required versions of GMP,
# MPFR, MPC installed via contrib/download_prerequisites.

set -eu

VERSION=${VERSION:=13.2.0}
BUILD=$ARCH-apple-darwin21
BOOTSTRAP=${BOOTSTRAP:=enable}   # or disable

PYTHON=python3.9

# exported so GCC sees it while compiling/linking: Monterey
export MACOSX_DEPLOYMENT_TARGET=12

TOP=/Volumes/Miscellaneous3

# override the default version if necessary
#  PREFIX=/opt/gcc-$VERSION-20232226-$ARCH

# for gcc-for-alire, gprbuild-for-alire
#  PREFIX=$TOP/alire-$ARCH/gcc

# the default version
PREFIX=${PREFIX:-/opt/gcc-$VERSION-$ARCH}

SRC_PATH=$TOP/src

GCC_SRC=$SRC_PATH/gcc-14-20240114
# that's a snapshot

# GCC_SRC=$SRC_PATH/gcc
# that's gcc-mirror

#  GCC_SRC=$SRC_PATH/gcc-13-branch
# actual branch in that clone is gcc-13.2-darwin.r0, i.e. 13.2.0

#  GCC_SRC=$SRC_PATH/gcc-darwin-arm64
# that's iains's WIP.

#  GCC_SRC=$SRC_PATH/gcc-14-20231126
# that's the latest snapshot

# the default version
GCC_SRC=${GCC_SRC:-$SRC_PATH/gcc-$VERSION}

NEW_PATH=$PREFIX/bin:$PATH

ADASAT_SRC=$SRC_PATH/AdaSAT
AUNIT_SRC=$SRC_PATH/aunit
GDB_PATH=$SRC_PATH/binutils-gdb
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
