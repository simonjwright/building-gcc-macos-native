script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

install_loc=$PREFIX/share/gprconfig

mkdir -p $install_loc

cp -p $GPRCONFIG_SRC/db/*.xml $install_loc/
