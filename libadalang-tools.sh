script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

# N.B. the upstream Makefile isn't a reference for good practice!

make -w -C $LIBADALANG_TOOLS_SRC DESTDIR=$PREFIX lib
make -w -C $LIBADALANG_TOOLS_SRC DESTDIR=$PREFIX bin
make -w -C $LIBADALANG_TOOLS_SRC DESTDIR=$PREFIX install-lib
make -w -C $LIBADALANG_TOOLS_SRC DESTDIR=$PREFIX install-bin-strip
