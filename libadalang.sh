set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

source ../langkit/venv/bin/activate

(
    cd $LIBADALANG_SRC

    rm -rf build

    pip install --upgrade pip

    pip install wheel

    pip install -r requirements-pypi.txt

    # For lib{lkt,python}lang.dylib
    # We need lib and lib/gcc/*/adalib
    libgcc=$(gcc -print-libgcc-file-name)
    adalib=$(dirname $libgcc)/adalib
    export DYLD_LIBRARY_PATH=$PREFIX/lib:$adalib

    python manage.py                                            \
           make                                                 \
           --build-mode=prod                                    \
           --library-types=relocatable,static-pic,static        \
           --disable-java

    # The runpaths in executables are unhelpful if $PREFIX isn't a
    # top-level directory, so use @executable_path.
    for f in $(find build/obj-mains/prod -type f); do
        if [[ $(file $f) == *executable* ]]; then
            $script_loc/fix_executable_rpaths.sh $f
        fi
    done
    
    # manage.py install --force didn't work (but saw -f ??)
    gprinstall --prefix=$PREFIX --uninstall libadalang || true

    python manage.py                                            \
           install                                              \
           --build-mode=prod                                    \
           --force                                              \
           --library-types=relocatable,static-pic,static        \
           $PREFIX
)

deactivate
