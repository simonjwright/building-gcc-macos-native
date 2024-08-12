# Build using extant GCC.

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

XCODE=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
CLT=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk

BUGURL=https://github.com/simonjwright/building-gcc-macos-native

echo "BUILDING THE COMPILER IN $PREFIX"

set -eu
rm -rf *

$GCC_SRC/configure                                                       \
    --prefix=$PREFIX                                                     \
    --enable-languages=c,c++,ada                                         \
    --build=$BUILD                                                       \
    --with-build-sysroot=$SDKROOT                                        \
    --with-specs="%{!sysroot=*:--sysroot=%:if-exists-else($XCODE $CLT)}" \
    --with-bugurl=$BUGURL                                                \
    --$BOOTSTRAP-bootstrap

make -w -j$CORES

make -w -j$CORES install

echo ###### NOT INSTALLING THE SHIM ######
exit

# Install the shim for ld
# Find the full path name for the C compiler's location
tool_path=$(dirname $($PREFIX/bin/gcc --print-prog-name=cc1))
echo "Installing in $tool_path"

# Write our shim there. If we're running a pre-15 SDK, there won't be
# an ld-classic, so use the standard linker.
#
# Need to keep a lookout for SDKs version > 15.
#
# We quote the EOF to avoid parameter substitution while writing the
# document.
cat >$tool_path/ld <<'EOF'
#!/bin/sh

classic=$(xcrun --find ld-classic 2>/dev/null) || true

if [ -n "$classic" ]; then
    exec $classic "$@"
else
    exec ld "$@"
fi

EOF

# It needs to be executable!
chmod +x $tool_path/ld

echo ###### NOT FIXING UP RPATHS ######
exit

# Fix up rpaths.
for exe in $PREFIX/bin/*; do
    if [[ $(file $exe) == *executable* ]]; then
        bash $script_loc/fix_executable_rpaths.sh $exe
    fi
done

for lib in $PREFIX/lib/*.dylib; do
    if [[ $(file $lib) == *shared\ library* ]]; then
        bash $script_loc/fix_library_rpaths.sh $lib
    fi
done

