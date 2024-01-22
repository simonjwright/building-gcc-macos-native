script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

# N.B. the upstream Makefile isn't a reference for good practice!

# Have to use BUILD_MODE=prod to avoid a warning-treated-as-error

make -w -C $LIBADALANG_TOOLS_SRC                \
     ALL_LIBRARY_TYPES=relocatable              \
     LIBRARY_TYPE=relocatable                   \
     BUILD_MODE=prod                            \
     clean

gprinstall --prefix=$PREFIX --uninstall lal_tools || true

make -w -C $LIBADALANG_TOOLS_SRC                \
     ALL_LIBRARY_TYPES=relocatable              \
     BUILD_MODE=prod                            \
     lib

make -w -C $LIBADALANG_TOOLS_SRC                \
     ALL_LIBRARY_TYPES=relocatable              \
     BUILD_MODE=prod                            \
     DESTDIR=$PREFIX                            \
     install-lib

make -w -C $LIBADALANG_TOOLS_SRC                \
     ALL_LIBRARY_TYPES=relocatable              \
     LIBRARY_TYPE=relocatable                   \
     BUILD_MODE=prod                            \
     bin

# Don't want to do this!
# make -w -C $SRC_PATH/libadalang-tools install-strip DESTDIR=$PREFIX/bin
# Instead,

export
function install()
{
    mkdir -p $PREFIX/bin
    strip $LIBADALANG_TOOLS_SRC/bin/gnat*
    cp $LIBADALANG_TOOLS_SRC/bin/gnat* $PREFIX/bin/
}

install
