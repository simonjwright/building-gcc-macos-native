set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

rm -rf venv
$PYTHON -m venv venv

source venv/bin/activate

(
    cd $LANGKIT_SRC

    rm -rf build

    pip install -r requirements-github.txt
    pip install -r requirements-pypi.txt

    pip install .

    python manage.py                        \
           build-langkit-support            \
           --library-types=relocatable

    # no --force in install-langkit-support
    gprinstall --prefix=$PREFIX --uninstall langkit_support || true

    python manage.py                        \
           install-langkit-support          \
           --library-types=relocatable      \
           $PREFIX
)

deactivate
