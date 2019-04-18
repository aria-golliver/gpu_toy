cmake_minimum_required(VERSION 3.9x)
project(simplefilewatcher)

add_library( simplefilewatcher
    source/FileWatcher.cpp
    source/FileWatcherWin32.cpp
    source/FileWatcherOSX.cpp
    source/FileWatcherLinux.cpp

    includes/FileWatcher/FileWatcher.h
    includes/FileWatcher/FileWatcherImpl.h
    includes/FileWatcher/FileWatcherWin32.h
    includes/FileWatcher/FileWatcherOSX.h
    includes/FileWatcher/FileWatcherLinux.h
)

target_include_directories( simplefilewatcher PUBLIC
includes/)