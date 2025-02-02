set(TARGET_NAME gears)
add_executable(${TARGET_NAME} main.c)

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang|AppleClang")
    target_compile_options(${TARGET_NAME} PRIVATE "-Wno-unused-parameter")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    target_compile_options(${TARGET_NAME} PRIVATE "/wd4244" "/wd4305" "/wd4100")
endif()

target_link_libraries(${TARGET_NAME} FreeGLUT::freeglut_static)
