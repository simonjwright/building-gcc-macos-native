script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

rm -rf venv
$PYTHON -m venv venv

source venv/bin/activate

(
    cd $LIBADALANG_SRC

    rm -rf build

    pip install --upgrade pip

    pip install wheel

    pip install -r REQUIREMENTS.dev

    (
        cd $LANGKIT_SRC

        rm -rf build

        pip install -r REQUIREMENTS.dev

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

    python manage.py generate

    python manage.py                            \
           build                                \
           --library-types=relocatable

    python manage.py                            \
           install                              \
           --force                              \
           --library-types=relocatable          \
           $PREFIX
)

deactivate
