set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

gprclean -p -P $ADASAT_SRC/adasat.gpr           \
         -XBUILD_MODE=prod                      \
         -XADASAT_LIBRARY_TYPE=relocatable

gprbuild -p -j$CORES -P $ADASAT_SRC/adasat.gpr  \
         -XBUILD_MODE=prod                      \
         -XADASAT_LIBRARY_TYPE=relocatable

gprinstall -f                                   \
           -p                                   \
           -P $ADASAT_SRC/adasat.gpr            \
           -XBUILD_MODE=prod                    \
           -XADASAT_LIBRARY_TYPE=relocatable    \
           --prefix=$PREFIX
