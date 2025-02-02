@echo off
setlocal

rem Author: Grinlex

cd sources

if not exist "..\bin\windows\freeglut" (
    echo Compiling freeglut
    mkdir "..\bin\windows\freeglut"
    cd freeglut
    if exist build (
        rmdir /s /q build
    )
    mkdir build
    cd build
    cmake -DINSTALL_PDB=ON -DFREEGLUT_BUILD_DEMOS=OFF -DCMAKE_INSTALL_PREFIX="..\..\..\bin\windows\freeglut" %* .. || exit /b 1
    cmake --build . --config Release --parallel || exit /b 1
    cmake --install . --config Release || exit /b 1
    cmake --build . --config Debug --parallel || exit /b 1
    cmake --install . --config Debug || exit /b 1
    robocopy "..\..\..\bin\windows\freeglut\bin" "..\..\..\bin\windows\freeglut\lib" "freeglutd.pdb" /z
    cd ..\
    rmdir /s /q build
    cd ..
)


echo Done.
