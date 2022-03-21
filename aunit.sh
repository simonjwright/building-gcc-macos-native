script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

make -w -j7                                     \
     -C $AUNIT_SRC                              \
     all

make -w                                         \
     -C $AUNIT_SRC                              \
     install
