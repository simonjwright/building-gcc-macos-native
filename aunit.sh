set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

make -w                                         \
     -C $AUNIT_SRC                              \
     GPRBUILD="gprbuild -j0 -gnatwn"            \
     all

make -w                                         \
     -C $AUNIT_SRC                              \
     install
