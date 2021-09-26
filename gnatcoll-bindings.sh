script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH:$PATH

cd $GNATCOLL_BINDINGS_SRC

(cd gmp
 ./setup.py clean
 ./setup.py build --reconfigure
 ./setup.py uninstall
 ./setup.py install
)

(cd iconv
 ./setup.py clean
 ./setup.py build --reconfigure
 ./setup.py uninstall
 ./setup.py install
)

# We can't do LZMA, because macOS doesn't support the multithreading option
# and the GNATCOLL code doesn't make it optional.
# (cd lzma
#  ./setup.py clean
#  ./setup.py build --reconfigure
#  ./setup.py uninstall
#  ./setup.py install
# )

(cd omp
 ./setup.py clean
 ./setup.py build --reconfigure
 ./setup.py uninstall
 ./setup.py install
)

(cd python3
 ./setup.py clean
 ./setup.py build --reconfigure
 ./setup.py uninstall
 ./setup.py install
)

(cd readline
 ./setup.py clean
 ./setup.py build --accept-gpl --reconfigure
 ./setup.py uninstall
 ./setup.py install
)

(cd syslog
 ./setup.py clean
 ./setup.py build --reconfigure
 ./setup.py uninstall
 ./setup.py install
)

(cd zlib
 ./setup.py clean
 ./setup.py build --reconfigure
 ./setup.py uninstall
 ./setup.py install
)
