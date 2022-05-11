script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

cd $GNATCOLL_BINDINGS_SRC

binding="gmp iconv lzma omp python3 readline syslog zlib"

# Reduce from the full list because:
# o We can't do LZMA, because macOS doesn't support the multithreading
#   option and the GNATCOLL code doesn't make it optional.
binding="gmp iconv omp python3 readline syslog zlib"

for bnd in $binding; do
    (cd $bnd
     set -eu
     rm -f setup.json
     find . -name \*.o | xargs rm -f
     ./setup.py clean
     case $bnd in
         readline)
             ./setup.py build --accept-gpl --reconfigure
             ;;
         *)
             ./setup.py build --reconfigure
             ;;
     esac
     ./setup.py install
    )
done
