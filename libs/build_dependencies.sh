#!/usr/bin/bash

# Author: Grinlex

cd sources

if [ ! -d "../bin/linux/freeglut" ]; then
    echo "Compiling freeglut"
    cd SDL
    if [ -d "build" ]; then
        rm -rf build
    fi
    mkdir -p build
    cd build
    cmake -DINSTALL_PDB=ON -DFREEGLUT_BUILD_DEMOS=OFF -DCMAKE_INSTALL_PREFIX="../../../bin/linux/freeglut" $* ..
    cmake --build . --config Release --parallel
    cmake --install . --config Release
    cmake --build . --config Debug --parallel
    cmake --install . --config Debug
    cd ../
    rm -rf build
    cd ../
fi


echo "Done."
