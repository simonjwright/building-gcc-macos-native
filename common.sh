# Ensure the GCC source tree already has required versions of GMP,
# MPFR, MPC installed via contrib/download_prerequisites.

VERSION=11.1.0
TOP=/Volumes/Miscellaneous1
PREFIX=$TOP/x86_64/gcc-$VERSION
BUILD=x86_64-apple-darwin15

SRC_PATH=$TOP/src
GCC_SRC=$SRC_PATH/gcc-$VERSION

# for full bootstrap build
GCC_BOOT_LDFLAGS="-static-libstdc++ -static-libgcc -Wl,-headerpad_max_install_names"
# for --disable-bootstrap build
GCC_STAGE1_LDFLAGS="-static-libstdc++ -static-libgcc -Wl,-headerpad_max_install_names"

NEW_PATH=$PREFIX/bin:$PATH

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
