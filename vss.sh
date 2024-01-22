set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

make -w -C $VSS_SRC                             \
     VSS_LIBRARY_TYPE=relocatable               \
     PREFIX=$PREFIX                             \
     all install
