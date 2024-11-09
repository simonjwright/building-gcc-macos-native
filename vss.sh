set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

(
    cd $VSS_SRC

    make clean

    make build-all-libs

    make install-all-libs PREFIX=$PREFIX
)
