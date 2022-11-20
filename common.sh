# Ensure the GCC source tree already has required versions of GMP,
# MPFR, MPC installed via contrib/download_prerequisites.

set -eu

VERSION=12.2.0
PREFIX=/opt/gcc-$VERSION
BUILD=aarch64-apple-darwin21

# exported so GCC sees it while compiling/linking: Monterey
export MACOSX_DEPLOYMENT_TARGET=12

TOP=/Volumes/Miscellaneous1

# override the above version if necessary
PREFIX=/opt/gcc-$VERSION-aarch64

SRC_PATH=$TOP/src

GCC_SRC=$SRC_PATH/gcc-$VERSION
# override the above version
GCC_SRC=$SRC_PATH/gcc-12-aarch64

NEW_PATH=$PREFIX/bin:$PATH

AUNIT_SRC=$SRC_PATH/aunit
GDB_PATH=$SRC_PATH/binutils-gdb
GNATCOLL_BINDINGS_SRC=$SRC_PATH/gnatcoll-bindings
GNATCOLL_CORE_SRC=$SRC_PATH/gnatcoll-core
GNATCOLL_DB_SRC=$SRC_PATH/gnatcoll-db
GPRBUILD_SRC=$SRC_PATH/gprbuild
GPRCONFIG_SRC=$SRC_PATH/gprconfig_kb
LANGKIT_SRC=$SRC_PATH/langkit
LIBADALANG_SRC=$SRC_PATH/libadalang
LIBADALANG_TOOLS_SRC=$SRC_PATH/libadalang-tools
TEMPLATES_PARSER_SRC=$SRC_PATH/templates-parser
XMLADA_SRC=$SRC_PATH/xmlada
