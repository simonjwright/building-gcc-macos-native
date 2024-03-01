# This script takes one parameter, the file name of an executable.
#
# The executable contains paths to the dynamic libraries (dylibs)
# which it uses (dependencies), so that the dylib can be found at run
# time.
#
# Clearly the path can be just the file name of the dylib (as it will
# be after installation), but this will likely cause problems if the
# distribution tree gets relocated. To avoid this, Darwin provides the
# name @rpath (e.g. @rpath/libfoo.dylib) which means that relative
# path information is baked into the executable as it is built, and
# used at run time to find the actual location of the dylib. This does
# require that the whole suite, executabls and dylibs, be moved as a
# unit.
#
# GNAT builds executables using @rpath: GCC doesn't.
#
# Names are manipulated using the install_name_tool. For dependencies,
# the syntax is
#
#   install_name_tool \
#       -change installed_path/libfoo.dylib @rpath/libfoo.dylib \
#       executable

set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

##########################

function handle_dependency () {
    # $1 is the full nane of the depended-on dylib
    if [[ $1 == *$PREFIX* ]]; then
        base_name=$(basename $1)
        echo "install_name_tool -change $1 @rpath/$base_name $target_file"
        eval "install_name_tool -change $1 @rpath/$base_name $target_file"
    fi
}
##########################

unset -v lines

target_file=$1

while IFS= read -r; do
     lines+=("$REPLY")
done < <(otool -L $target_file)


for line in "${lines[@]:1:${#lines[@]}}"; do
    handle_dependency "$(echo $line | cut -d " " -f1)"
done

