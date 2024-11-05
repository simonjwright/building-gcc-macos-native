set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

echo building
gprbuild                                        \
    -P $PRETTIER_ADA_SRC/prettier_ada           \
    -XPRETTIER_ADA_BUILD_MODE=prod              \
    -XLIBRARY_TYPE=relocatable

echo uninstalling
gprinstall                                      \
    --prefix=$PREFIX                            \
    --uninstall                                 \
    prettier_ada                                \
    || true

echo installing
gprinstall                                      \
    -f                                          \
    -P $PRETTIER_ADA_SRC/prettier_ada           \
    --prefix=$PREFIX                            \
    --install-name=prettier_ada                 \
    -XPRETTIER_ADA_BUILD_MODE=prod              \
    --mode=dev                                  \
    -XLIBRARY_TYPE=relocatable                  \
    --create-missing-dirs                       \
    --build-var=LIBRARY_TYPE                    \
    --build-name=relocatable

    
