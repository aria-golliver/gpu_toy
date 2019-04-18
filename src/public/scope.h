#pragma once

#include <functional>

class Scope {
public:
    Scope(const std::function<void(void)>& _f) : f(_f) {};
    ~Scope() { f(); }
private:
    std::function<void(void)> f;
};
