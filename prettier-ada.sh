set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

(
    cd $PRETTIER_ADA_SRC

    echo cleaning
    make clean

    echo building
    make all BUILD_MODE=prod

    echo installing
    make install-all PREFIX=$PREFIX BUILD_MODE=prod
)
    
