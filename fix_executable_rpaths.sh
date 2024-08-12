#!/usr/bin/env bash
# because of the wierd reading of the lines array at the end.

# This script takes one parameter, the file name of an executable.
#
# The executable contains paths to the dynamic libraries (dylibs)
# which it uses (dependencies), so that the dylib can be found at run
# time.
#
# Clearly the path can be just the full name of the dylib (as it will
# be after installation), but this will likely cause problems if the
# distribution tree gets relocated.
#
# To avoid this, Darwin provides the symbolic names @executable_path
# and @rpath.

# If an executable requires a dynamic library, it'll be tagged by its
# identity (id), as determined when the library was built. By default,
# that'll be the path name of the library; alternatively, it can be
# e.g. '@rpath/libfoo.dylib', which tells the loader to look for the
# library along the 'run path' baked into the executable at build
# time.
#
# All well and good, until the suite is moved. The standard solution
# does require that the whole suite, executables and dylibs, be moved
# as a unit.
#
# GNAT builds libraries and executables using @rpath: in some cases
# GCC doesn't.
#
# Names are manipulated using the install_name_tool. For dependencies,
# the syntax is
#
#   install_name_tool \
#       -change installed_path/libfoo.dylib @rpath/libfoo.dylib \
#       executable
#
# The run path in the executable can be added to by the
# install_name_tool switch -add_rpath. What we need to link are the
# lib/ and adalib/ directories: e.g.
#
#   install_name_tool -add_rpath @executable_path/../lib executable
#
# where @executable_path translates to the directory from which
# 'executable' was loaded.
#

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

function set_rpath () {
    # $1 is the name of the executable
    adalib=$(cd $PREFIX; find lib -type d -name adalib)
    echo "install_name_tool -add_rpath @executable_path/../lib $1"
    install_name_tool -add_rpath @executable_path/../lib $1
    echo "install_name_tool -add_rpath @executable_path/../$adalib $1"
    install_name_tool -add_rpath @executable_path/../$adalib $1
}

##########################

set_rpath $1

unset -v lines

target_file=$1

while IFS= read -r; do
     lines+=("$REPLY")
done < <(otool -L $target_file)

for line in "${lines[@]:1:${#lines[@]}}"; do
    handle_dependency "$(echo $line | cut -d " " -f1)"
done

