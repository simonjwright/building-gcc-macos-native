script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

make -w -j3                                     \
     -C $AUNIT_SRC                              \
     GPRBUILD_OPTIONS="--db $script_loc/config" \
     all

make -w -j3                                     \
     -C $AUNIT_SRC                              \
     GPRBUILD_OPTIONS="--db $script_loc/config" \
     install
