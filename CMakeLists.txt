cmake_minimum_required(VERSION 3.28)

set(PROJECT_NAME "NewFeatures")

project(${PROJECT_NAME} LANGUAGES CXX C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
message(STATUS "Using C standard: c${CMAKE_C_STANDARD}")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message(STATUS "Using C++ standard: c++${CMAKE_CXX_STANDARD}")

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang|AppleClang")
    add_compile_options(
        "-Wall" "-Wextra" "-Wpedantic"
        "$<$<CONFIG:Release>:-Werror>"
    )
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    add_compile_options(
        "/W4" "/utf-8" "/Zc:__cplusplus"
        "$<$<CONFIG:Release>:/WX>"
    )
else()
    message(WARNING "${PROJECT_NAME} compiles only on gcc, clang, apple clang or msvc! I have no idea if everything is going to be okay")
endif()

set(LIBS_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/.output/$<CONFIG>/libs)
set(DLLS_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/.output/$<CONFIG>/bin)
set(ROOT_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/.output/$<CONFIG>)

if(WIN32)
    set(BUILD_SCRIPT_CMD cmd.exe /c ${PROJECT_SOURCE_DIR}/libs/build_dependencies.cmd)
    set(CMAKE_PREFIX_PATH ${PROJECT_SOURCE_DIR}/libs/bin/windows)
    include_directories(${PROJECT_SOURCE_DIR}/libs/bin/windows)
else()
    set(BUILD_SCRIPT_CMD bash ${PROJECT_SOURCE_DIR}/libs/build_dependencies.sh)
    set(CMAKE_PREFIX_PATH ${PROJECT_SOURCE_DIR}/libs/bin/linux)
    include_directories(${PROJECT_SOURCE_DIR}/libs/bin/linux)
endif()

find_package(OpenGL REQUIRED)

execute_process(
    COMMAND ${BUILD_SCRIPT_CMD}
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/libs/
)

find_package(FreeGLUT REQUIRED)

add_subdirectory(src)
