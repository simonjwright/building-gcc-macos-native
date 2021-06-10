script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

cd $GNATCOLL_BINDINGS_SRC

(cd gmp
 ./setup.py clean
 ./setup.py build --reconfigure --gpr-opts --db $script_loc/config
 ./setup.py uninstall
 ./setup.py install
)

(cd iconv
 ./setup.py clean
 ./setup.py build --reconfigure --gpr-opts --db $script_loc/config
 ./setup.py uninstall
 ./setup.py install
)

(cd python3
 python3 ./setup.py clean
 python3 ./setup.py build --reconfigure --gpr-opts --db $script_loc/config
 python3 ./setup.py uninstall
 python3 ./setup.py install
)

(cd readline
 ./setup.py clean
 ./setup.py build --accept-gpl --reconfigure --gpr-opts --db $script_loc/config
 ./setup.py uninstall
 ./setup.py install
)

(cd syslog
 ./setup.py clean
 ./setup.py build --reconfigure --gpr-opts --db $script_loc/config
 ./setup.py uninstall
 ./setup.py install
)
