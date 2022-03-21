script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

rm -rf *

$GCC_SRC/gmp/configure                          \
  --prefix=$PREFIX                              \
  --host=$BUILD                                 \
  --enable-cxx                                  \
  --enable-shared

make -w -j7

# Can't find a way to make the shared library identities to start
# @rpath, so fix up.
(
    set -eu
    cd .libs
    for lib in $(find . -type f -name \*.dylib); do
        # remove the leading "./"
        l=$(echo $lib | cut -b3-)
        install_name_tool -id @rpath/$l $lib
    done
)

make install
