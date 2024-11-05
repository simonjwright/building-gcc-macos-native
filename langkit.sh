set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

rm -rf venv
$PYTHON -m venv venv

source venv/bin/activate
pip install --upgrade pip

(
    cd $LANGKIT_SRC

    # Don't really want to clone adasat at <what> version.
    rm -rf langkit/adasat
    ln -s $ADASAT_SRC langkit/adasat
    
    rm -rf build

    pip install -r requirements-pypi.txt

    pip install .

    # This is for the 25.0.0 branch, like 25.1, as used in ada_language_parser
    python                                      \
        manage.py                               \
        make                                    \
        --no-mypy                               \
        --generate-auto-dll-dirs                \
        --library-types=relocatable             \
        --gargs '-cargs -fPIC'
    
    # no --force in install-langkit-support
    gprinstall --prefix=$PREFIX --uninstall langkit_support || true

    python manage.py                        \
           install-langkit-support          \
           --library-types=relocatable      \
           $PREFIX

    (cd contrib/python
     python                                     \
         ./manage.py                            \
         install                                \
         $PREFIX                                \
         --library-types=relocatable            \
         --disable-all-mains
    )

    pip install contrib/python/build/python

    (cd contrib/lkt
     python                                     \
         ./manage.py                            \
         install                                \
         $PREFIX                                \
         --library-types=relocatable            \
         --disable-all-mains
    )

    pip install contrib/lkt/build/python

)

deactivate
