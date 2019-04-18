#pragma once

#include "file_watcher.h"


LambdaListener::LambdaListener(std::function<void()>& func) : _func(func) {}
LambdaListener::~LambdaListener() = default;
void LambdaListener::handleFileAction(FW::WatchID, const FW::String&, const FW::String&, FW::Action) {
    _func();
}
SimpleFileWatcher::SimpleFileWatcher(const std::string& path)
    : changed(false)
    , listener(std::function<void(void)>([&]() {changed = true; }))
{
    fileWatcher.addWatch(path, &listener);
}

SimpleFileWatcher::~SimpleFileWatcher() = default;

bool SimpleFileWatcher::CheckChanged() {
    Scope([&]() { changed = false; });
    fileWatcher.update();
    return changed;
}