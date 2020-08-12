set -x

if cmake.exe --version; then
    echo "cmake already in path..."
else
    echo "cmake not available, installing."
    ROOT="$(cygpath -m /)"
    echo "cygwin root: $ROOT"
    LOCAL_PACKAGE_DIR="$(cygpath -w /var/cache/setup)"

    $ROOT/setup-x86_64.exe --root $ROOT -q --packages=cmake --local-package-dir $LOCAL_PACKAGE_DIR --site=http://cygwin.mirror.constant.com/ --no-desktop --no-startmenu --no-shortcuts --verbose

    CMAKE_FOLDER="$(find /usr/share -maxdepth 1 -name cmake-*)"
    CMAKE_DIRNAME="$(basename $CMAKE_FOLDER)"

    echo "folder: $CMAKE_FOLDER"
    echo "dirname: $CMAKE_DIRNAME"

    echo "Copying to $cur__bin/cmake.exe"
    cp /usr/bin/cmake.exe $cur__bin/cmake.exe
    cp /usr/bin/cygarchive-13.dll $cur__bin/cygarchive-13.dll

    echo "Copying to $cur__share/$CMAKE_DIRNAME"
    cp -r $CMAKE_FOLDER $cur__share/$CMAKE_DIRNAME

    echo "Checking cmake version (/usr/bin):"
    OUTPUT="$(/usr/bin/cmake.exe --version)"
    echo "/usr/bin version is: $OUTPUT"

    echo "Checking cmake version (copied):"
    strace $cur__bin/cmake.exe
fi
