#pragma once
#if defined(_WIN32)
#include <windows.h>
#endif
#include <string>
#include <fstream>
#include <streambuf>

namespace {
    void ClearCmd() {
#if defined(_WIN32)
        COORD topLeft = { 0, 0 };
        HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE);
        CONSOLE_SCREEN_BUFFER_INFO screen;
        DWORD written;

        GetConsoleScreenBufferInfo(console, &screen);
        FillConsoleOutputCharacterA(
            console, ' ', screen.dwSize.X * screen.dwSize.Y, topLeft, &written
        );
        FillConsoleOutputAttribute(
            console, FOREGROUND_GREEN | FOREGROUND_RED | FOREGROUND_BLUE,
            screen.dwSize.X * screen.dwSize.Y, topLeft, &written
        );
        SetConsoleCursorPosition(console, topLeft);
#endif
    }

    std::string LoadFile(const std::string& path) {
        std::ifstream inputFileStream(path);
        return std::string{ std::istreambuf_iterator<char>(inputFileStream),
            std::istreambuf_iterator<char>() };
    }
}