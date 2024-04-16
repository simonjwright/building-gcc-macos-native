set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

#  rm -rf venv
#  $PYTHON -m venv venv

source ../langkit/venv/bin/activate

(
    cd $LIBADALANG_SRC

    rm -rf build

    pip install --upgrade pip

    pip install wheel

    pip install -r REQUIREMENTS.dev

    python manage.py generate

    python manage.py                            \
           build                                \
           --build-mode=prod                    \
           --library-types=relocatable          \
           --disable-java

    # The runpaths in executables are unhelpful if $PREFIX isn't a
    # top-level directory, so use @executable_path.
    for f in $(find build/obj-mains/prod -type f); do
        if [[ $(file $f) == *executable* ]]; then
            $script_loc/fix_executable_rpaths.sh $f
        fi
    done
    
    python manage.py                            \
           install                              \
           --build-mode=prod                    \
           --force                              \
           --library-types=relocatable          \
           $PREFIX
)

deactivate
