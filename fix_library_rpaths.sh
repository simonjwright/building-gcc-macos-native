# This script takes one parameter, the file name of a dynamic library
# (dylib).
#
# The dylib contains two kinds of naming information: its
# identification, and paths to the other dylibs which it uses
# (dependencies). The identification is what is used when building
# another dylib or an executable so that this dylib can be found at
# run time.
#
# Clearly the identification can be just the file name of the dylib
# (as it will be after installation), but this will likely cause
# problems if the distribution tree gets relocated. To avoid this,
# Darwin provides the name @rpath (e.g. @rpath/libfoo.dylib) which
# means that relative path information is baked into the executable as
# it is built, and used at run time to find the actual location of the
# dylib. This does require that the whole suite, executabls and
# dylibs, be moved as a unit.
#
# GNAT builds libraries using @rpath: GCC doesn't.
#
# Names are manipulated using the install_name_tool. For
# identification, the syntax is
#
#   install_name_tool -id @rpath/libfoo.dylib current_path/foo.dylib
#
# and for dependencies
#
#   install_name_tool \
#       -change installed_path/libfoo.dylib @rpath/libfoo.dylib \
#       current_path/foo.dylib

set -eu

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

##########################

# This is used for dylibs only.
function handle_identification () {
    # $1 is the dylib's identification name.
    if [[ $1 == *$PREFIX* ]]; then
        base_name=$(basename $1)
        echo "install_name_tool -id @rpath/$base_name $target_file"
        eval "install_name_tool -id @rpath/$base_name $target_file"
    fi
}

# This can be used for dylibs and executables.
function handle_dependency () {
    # $1 is the full nane of the depended-on dylib
    if [[ $1 == *$PREFIX* ]]; then
        base_name=$(basename $1)
        echo "install_name_tool -change $1 @rpath/$base_name $target_file"
        eval "install_name_tool -change $1 @rpath/$base_name $target_file"
    fi
}

##########################

target_file=$1

lines=()
while IFS= read -r; do
     lines+=("$REPLY")
done < <(otool -L $target_file)

echo "id line: ${lines[1]}"

handle_identification "$(echo ${lines[1]} | cut -d " " -f1)"

for line in "${lines[@]:2:${#lines[@]}}"; do
    handle_dependency "$(echo $line | cut -d " " -f1)"
done

