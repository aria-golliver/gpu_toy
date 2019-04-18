#pragma once

// we need a header to define those things bellow
// <filesystem> includes vector to work anyway so it shouldn't waste much compile time
#include <vector>

#if !_HAS_CXX17 || !defined(_WIN32)
#include <experimental/filesystem>
namespace fs = std::experimental::filesystem;
#else
#include <filesystem>
namespace fs = std::filesystem;
#endif
