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

    # Don't really want to clone adasat at possibly-different version.
    rm -rf langkit/adasat
    ln -s $ADASAT_SRC langkit/adasat
    
    rm -rf build

    pip install -r requirements-pypi.txt

    pip install .

    python                                              \
        manage.py                                       \
        make                                            \
        --no-mypy                                       \
        --generate-auto-dll-dirs                        \
        --build-mode=prod                               \
        --library-types relocatable,static-pic,static   \
        --gargs '-cargs -fPIC'
    
    # no --force in install-langkit-support
    gprinstall --prefix=$PREFIX --uninstall langkit_support || true

    python manage.py                                            \
           install-langkit-support                              \
           --build-mode=prod                                    \
           --library-types relocatable,static-pic,static        \
           $PREFIX

    (
        cd contrib/python                                       \

        # manage.py install --force doesn't work
        gprinstall --prefix=$PREFIX --uninstall libpythonlang || true

        python                                                  \
            ./manage.py                                         \
            install                                             \
            --force                                             \
            $PREFIX                                             \
            --library-types=relocatable,static-pic,static       \
            --build-mode=prod                                   \
            --disable-all-mains
    )

    pip install contrib/python/build/python

    (
        cd contrib/lkt

        # manage.py install --force doesn't work
        gprinstall --prefix=$PREFIX --uninstall liblktlang || true

        python                                                  \
            ./manage.py                                         \
            install                                             \
            --force                                             \
            $PREFIX                                             \
            --library-types=relocatable,static-pic,static       \
            --build-mode=prod                                   \
            --disable-all-mains
    )

    pip install contrib/lkt/build/python

)

deactivate
