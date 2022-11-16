set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

make -w -C $TEMPLATES_PARSER_SRC clean

make -w -C $TEMPLATES_PARSER_SRC                \
     DEFAULT_LIBRARY_TYPE=relocatable           \
     prefix=$PREFIX                             \
     setup build install
