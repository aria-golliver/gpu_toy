
#include "gtest/gtest.h"
#include "file_watcher.h"
#include "filesystem_include.h"

#include <fstream>
#include <thread>
#include <cstdio>

TEST(FileWatcher, LambdaListener) {
    bool worked = false;
    auto func = [&]{worked=true;};
    auto listener = LambdaListener(func);
    listener.handleFileAction(0,"","",FW::Action::Add);
    ASSERT_TRUE(worked);
}

TEST(FileWatcher, DetectsNoFileChanges) {
    auto watcher = SimpleFileWatcher{"."};
    ASSERT_FALSE(watcher.CheckChanged());
}

TEST(FileWatcher, DetectsFileCreated) {
    auto temp_path = fs::temp_directory_path();
    auto temp_file = (temp_path / "test.txt").string();

    auto watcher = SimpleFileWatcher{(temp_path).string()};
    std::ofstream file;
    file.open(temp_file);
    file.close();
    
    ASSERT_TRUE(watcher.CheckChanged());
    std::remove(temp_file.c_str());
}

TEST(FileWatcher, DetectsFileDeleted) {
    auto temp_path = fs::temp_directory_path();
    auto temp_file = (temp_path / "test.txt").string();

    std::ofstream file;
    file.open(temp_file);
    file.close();

    auto watcher = SimpleFileWatcher{(temp_path).string()};
    ASSERT_FALSE(watcher.CheckChanged());
    std::remove(temp_file.c_str());
    ASSERT_TRUE(watcher.CheckChanged());
}

TEST(FileWatcher, DetectsFileChanged) {
    auto temp_path = fs::temp_directory_path();
    auto temp_file = (temp_path / "test.txt").string();
    {
        std::ofstream file;
        file.open(temp_file);
        file.close();
    }

    auto watcher = SimpleFileWatcher{(temp_path).string()};
    ASSERT_FALSE(watcher.CheckChanged());
    {
        std::ofstream file;
        file.open(temp_file);
        file << "\n";
        file.close();
    }
    ASSERT_TRUE(watcher.CheckChanged());
    std::remove(temp_file.c_str());
}