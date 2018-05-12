# Ensure the GCC source tree already has required versions of GMP,
# MPFR, MPC installed via contrib/download_prerequisites.

VERSION=8.1.0
TOP=/Volumes/Miscellaneous
PREFIX=$TOP/tmp/opt/gcc-$VERSION
BUILD=x86_64-apple-darwin15

SRC_PATH=$TOP/tmp
GCC_SRC=$SRC_PATH/gcc-$VERSION

GCC_BOOT_FLAGS="-static-libstdc++ -static-libgcc -Wl,-headerpad_max_install_names"

NEW_PATH=$PREFIX/bin:$PATH

XMLADA_SRC=$SRC_PATH/xmlada
GPRBUILD_SRC=$SRC_PATH/gprbuild
GNAT_UTIL_SRC=$SRC_PATH/gnat_util
AUNIT_SRC=$SRC_PATH/aunit-gpl-2017-src
GNATCOLL_CORE_SRC=$SRC_PATH/gnatcoll-core
GNATCOLL_DB_SRC=$SRC_PATH/gnatcoll-db
GNATCOLL_BINDINGS_SRC=$SRC_PATH/gnatcoll-bindings
ASIS_SRC=$SRC_PATH/ASIS
GDB_PATH=$SRC_PATH/gdb-7.10-gpl-2017-src
