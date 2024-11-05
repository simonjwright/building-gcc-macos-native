script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$NEW_PATH

for prj in minimal core projects; do
    $GNATCOLL_CORE_SRC/$prj/gnatcoll_$prj.gpr.py        \
         build                                          \
         --jobs 0                                       \
         --prefix $PREFIX                               \
         --enable-constant-updates                      \
         --install
done

cp $GNATCOLL_CORE_SRC/gnatcoll.gpr $PREFIX/share/gpr/
