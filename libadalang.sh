script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

rm -rf venv
python3 -m venv venv

source venv/bin/activate

(
    cd $LIBADALANG_SRC

    pip install --upgrade pip

    pip install wheel

    pip install -r REQUIREMENTS.dev

    pip install $LANGKIT_SRC

    python ada/manage.py generate

    python ada/manage.py \
           --library-types=static,static-pic,relocatable build

    python ada/manage.py \
           --library-types=static,static-pic,relocatable install -f $PREFIX
)

deactivate
