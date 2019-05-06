script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

START=$PWD

PATH=$NEW_PATH:$PATH

cd $GNATCOLL_DB_SRC

make -w -C sql setup prefix=$PREFIX
make -w -C sql clean build GPRBUILD_OPTIONS="--db $script_loc/config"
make -w -C sql install

make -w -C sqlite setup prefix=$PREFIX
make -w -C sqlite clean build GPRBUILD_OPTIONS="--db $script_loc/config"
make -w -C sqlite install

make -w -C xref setup prefix=$PREFIX
make -w -C xref GPRBUILD_OPTIONS="--db $script_loc/config"
make -w -C xref install

make -w -C gnatinspect setup prefix=$PREFIX
make -w -C gnatinspect clean build GPRBUILD_OPTIONS="--db $script_loc/config"
make -w -C gnatinspect install

make -w -C gnatcoll_db2ada setup prefix=$PREFIX DB_BACKEND=sqlite
make -w -C gnatcoll_db2ada clean build GPRBUILD_OPTIONS="--db $script_loc/config"
make -w -C gnatcoll_db2ada install
