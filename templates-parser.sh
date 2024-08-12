set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

make -w -C $TEMPLATES_PARSER_SRC clean

# Have to separate the following, because install doesn't depend on
# build. Not sure about setup, but won't take long.

make -w -C $TEMPLATES_PARSER_SRC                \
     DEFAULT_LIBRARY_TYPE=relocatable           \
     prefix=$PREFIX                             \
     setup

make -w -j$CORES -C $TEMPLATES_PARSER_SRC        \
     DEFAULT_LIBRARY_TYPE=relocatable           \
     prefix=$PREFIX                             \
     build

make -w -C $TEMPLATES_PARSER_SRC                \
     DEFAULT_LIBRARY_TYPE=relocatable           \
     prefix=$PREFIX                             \
     install
