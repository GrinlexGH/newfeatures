cmake_minimum_required(VERSION 3.15)
project(gears C)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(FreeGLUT REQUIRED)

add_executable(${PROJECT_NAME} src/main.c)
target_link_libraries(${PROJECT_NAME} FreeGLUT::freeglut_static)
