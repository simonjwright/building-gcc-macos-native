# Ensure the GCC source tree already has required versions of GMP,
# MPFR, MPC installed via contrib/download_prerequisites.

PREFIX=/opt/gnat-ce-2021

TOP=/Volumes/Miscellaneous1
BUILD=x86_64-apple-darwin15

SRC_PATH=$TOP/src/gnat-ce-2021
GCC_SRC=$SRC_PATH/gcc-10-2021-20210519-19A74-src

# for full bootstrap build
GCC_BOOT_LDFLAGS="-static-libstdc++ -static-libgcc -Wl,-headerpad_max_install_names"
# for --disable-bootstrap build
GCC_STAGE1_LDFLAGS="-static-libstdc++ -static-libgcc -Wl,-headerpad_max_install_names"

NEW_PATH=$PREFIX/bin:$PATH

# full Xcode
SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

AUNIT_SRC=$SRC_PATH/aunit-2021-20210518-19DC5-src
GDB_PATH=$SRC_PATH/../gdb-10.2                       # macOS patched version
GNATCOLL_BINDINGS_SRC=$SRC_PATH/gnatcoll-bindings-2021-20210518-19B15-src
GNATCOLL_CORE_SRC=$SRC_PATH/gnatcoll-core-2021-20210518-19ADF-src
GNATCOLL_DB_SRC=$SRC_PATH/../gnatcoll-db             # not p/o CE downloads
GPRBUILD_SRC=$SRC_PATH/gprbuild-2021-20210519-19A34-src
#GPRCONFIG_SRC=$SRC_PATH/gprconfig_kb                # probably not needed
LANGKIT_SRC=$SRC_PATH/langkit-2021-20210518-19B8E-src
LIBADALANG_SRC=$SRC_PATH/libadalang-2021-20210518-199BE-src
LIBADALANG_TOOLS_SRC=$SRC_PATH/libadalang-tools-2021-20210519-19A69-src
XMLADA_SRC=$SRC_PATH/xmlada-2021-20210518-19D50-src
