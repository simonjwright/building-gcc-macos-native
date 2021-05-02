script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

python3 -m venv venv

source venv/bin/activate

(
    cd $SRC_PATH/langkit

    pip install REQUIREMENTS.dev

    python manage.py \
           make build-langkit-support \
           --library-types=static,static-pic,relocatable

    python $SRC_PATH/langkit/manage.py \
           make install-langkit-support $PREFIX \
           --library-types=static,static-pic,relocatable
)
