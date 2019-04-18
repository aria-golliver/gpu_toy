#pragma once

#include <functional>
#include <string>

#include <FileWatcher/FileWatcher.h>

#include "scope.h"

class LambdaListener : public FW::FileWatchListener {
public:
    LambdaListener(std::function<void()>& func);
    ~LambdaListener() override;
    void handleFileAction(FW::WatchID, const FW::String&, const FW::String&, FW::Action) override;

private:
    const std::function<void()> _func;
};

class SimpleFileWatcher {
public:
    SimpleFileWatcher(const std::string& path);
    ~SimpleFileWatcher();
    bool CheckChanged();

private:
    bool changed;
    LambdaListener listener;
    FW::FileWatcher fileWatcher;
};