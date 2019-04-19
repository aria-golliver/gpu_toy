#pragma once

#include <functional>

class Scope {
public:
    Scope(const std::function<void(void)>& _f);
    Scope(const Scope& other);
    Scope(Scope&& other);
    Scope& operator=(const Scope& other);
    Scope& operator=(Scope&& other);
    ~Scope();
private:
    std::function<void(void)> f;
};
