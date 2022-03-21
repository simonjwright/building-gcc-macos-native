script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

START=$PWD

PATH=$NEW_PATH

cd $GNATCOLL_DB_SRC

components="sql sqlite xref gnatinspect gnatcoll_db2ada"

for cmp in $components; do
    make -w -C $cmp setup prefix=$PREFIX BUILD=PROD TARGET=$BUILD
    make -w -C $cmp clean build
    make -w -C $cmp install
done
