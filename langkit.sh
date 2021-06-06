script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

python3 -m venv venv

source venv/bin/activate

(
    cd $LANGKIT_SRC

    pip install --upgrade pip

    pip install wheel

    pip install -r REQUIREMENTS.dev

    python manage.py \
           build-langkit-support \
           --library-types=static,static-pic,relocatable

    python manage.py \
           install-langkit-support $PREFIX \
           --library-types=static,static-pic,relocatable
)
