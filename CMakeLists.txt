cmake_minimum_required(VERSION 3.9x)

project(GpuToy)

set(BUILD_SHARED_LIBS false)
set(CMAKE_CXX_STANDARD 17)

add_subdirectory(deps/SFML-2.5.1)
add_subdirectory(deps/simplefilewatcher)

add_executable(gpu_toy
    src/main/gpu_toy.cpp
    src/main/gpu_toy.h
    src/main/shader_header.h
    src/main/file_watcher.h
    src/main/file_watcher.cpp
    src/main/scope.h
    src/main/live_reloading_shader.cpp
    src/main/live_reloading_shader.h
)

target_link_libraries(gpu_toy PRIVATE
    sfml-graphics
    sfml-system
    sfml-window
    simplefilewatcher
)

if (UNIX)
    target_link_libraries(gpu_toy PRIVATE stdc++fs)
endif()

configure_file(GTestCMakeLists.txt googletest-download/CMakeLists.txt)

execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
    RESULT_VARIABLE result
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
if(result)
    message(FATAL_ERROR "CMake step for googletest failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
    RESULT_VARIABLE result
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
if(result)
    message(FATAL_ERROR "Build step for googletest failed: ${result}")
endif()

set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/googletest-src
                 ${CMAKE_CURRENT_BINARY_DIR}/googletest-build
                 EXCLUDE_FROM_ALL)

add_executable(gpu_toy_test src/test/test.cpp)
target_link_libraries(gpu_toy_test gtest_main)
enable_testing()
add_test(NAME    gpu_toy_test
         COMMAND gpu_toy_test)