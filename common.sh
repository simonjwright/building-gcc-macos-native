# Ensure the GCC source tree already has required versions of GMP,
# MPFR, MPC installed via contrib/download_prerequisites.

VERSION=12.0.1
PREFIX=/opt/gcc-12.0.1

TOP=/Volumes/Miscellaneous1
BUILD=x86_64-apple-darwin15

SRC_PATH=$TOP/src
GCC_SRC=$SRC_PATH/gcc-$VERSION
GCC_SRC=$SRC_PATH/gcc

NEW_PATH=$PREFIX/bin:$PATH

# full Xcode
SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

AUNIT_SRC=$SRC_PATH/aunit
GDB_PATH=$SRC_PATH/gdb-10.2
GNATCOLL_BINDINGS_SRC=$SRC_PATH/gnatcoll-bindings
GNATCOLL_CORE_SRC=$SRC_PATH/gnatcoll-core
GNATCOLL_DB_SRC=$SRC_PATH/gnatcoll-db
GPRBUILD_SRC=$SRC_PATH/gprbuild
GPRCONFIG_SRC=$SRC_PATH/gprconfig_kb
LANGKIT_SRC=$SRC_PATH/langkit
LIBADALANG_SRC=$SRC_PATH/libadalang
LIBADALANG_TOOLS_SRC=$SRC_PATH/libadalang-tools
XMLADA_SRC=$SRC_PATH/xmlada
