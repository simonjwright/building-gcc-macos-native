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
           --library-types=relocatable          \
           --disable-java

    python manage.py                            \
           install                              \
           --force                              \
           --library-types=relocatable          \
           $PREFIX
)

deactivate
