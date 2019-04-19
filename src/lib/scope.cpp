#include "scope.h"

#include <functional>

Scope::Scope(const std::function<void(void)>& _f) : f(_f) {
}

Scope::Scope(const Scope& other) {
    *this = other;
}

Scope::Scope(Scope&& other) {
    *this = std::move(other);
}

Scope& Scope::operator=(const Scope& other) {
    if(f) f();
    f = other.f;
    return *this;
}

Scope& Scope::operator=(Scope&& other) {
    if(f) f();
    f = nullptr;
    std::swap(f, other.f);
    return *this;
}

Scope::~Scope() {
    if(f) f();
}
