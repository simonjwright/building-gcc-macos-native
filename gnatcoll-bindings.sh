script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

cd $GNATCOLL_BINDINGS_SRC

(cd gmp
./setup.py build --db $script_loc/config
./setup.py install
)

(cd iconv
./setup.py build --db $script_loc/config
./setup.py install
)

(cd python
./setup.py build --db $script_loc/config
./setup.py install
)

(cd readline
./setup.py build --accept-gpl --db $script_loc/config
./setup.py install
)

(cd syslog
./setup.py build --db $script_loc/config
./setup.py install
)
