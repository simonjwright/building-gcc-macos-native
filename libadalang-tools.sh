script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

# N.B. the upstream Makefile isn't a reference for good practice!

make -w -C $LIBADALANG_TOOLS_SRC clean
make -w -C $LIBADALANG_TOOLS_SRC lib

# Don't want to do this!
# make -w -C $SRC_PATH/libadalang-tools install-strip DESTDIR=$PREFIX/bin
# Instead,

function install()
{
    mkdir -p $PREFIX/bin
    strip $LIBADALANG_TOOLS_SRC/bin/gnat*
    cp $LIBADALANG_TOOLS_SRC/bin/gnat* $PREFIX/bin/
}

install
