set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

(
    library_types="static static-pic relocatable"
    
    cd $ADASAT_SRC

    for type in $library_types; do
        make clean LIBRARY_TYPE=$type BUILD_MODE=prod
    done

    make all-libs BUILD_MODE=prod

    for type in $library_types; do
        make install INSTALL_DIR=$PREFIX LIBRARY_TYPE=$type BUILD_MODE=prod
    done
)
