////////////////////////////////////////////////////////////
//
// SFML - Simple and Fast Multimedia Library
// Copyright (C) 2007-2018 Laurent Gomila (laurent@sfml-dev.org)
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it freely,
// subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented;
//    you must not claim that you wrote the original software.
//    If you use this software in a product, an acknowledgment
//    in the product documentation would be appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such,
//    and must not be misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.
//
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// Headers
////////////////////////////////////////////////////////////
#include <SFML/Graphics/Color.hpp>
#include <algorithm>


namespace sf
{
////////////////////////////////////////////////////////////
// Static member data
////////////////////////////////////////////////////////////
const Color Color::Black(0.f, 0, 0);
const Color Color::White(1.f, 1, 1);
const Color Color::Red(1.f, 0, 0);
const Color Color::Green(0, 1.f, 0);
const Color Color::Blue(0, 0, 1.f);
const Color Color::Yellow(1.f, 1.f, 0);
const Color Color::Magenta(1.f, 0, 1.f);
const Color Color::Cyan(0, 1.f, 1.f);
const Color Color::Transparent(0.f, 0, 0, 0);


////////////////////////////////////////////////////////////
Color::Color() :
r(0),
g(0),
b(0),
a(1.f)
{

}


////////////////////////////////////////////////////////////
Color::Color(float red, float green, float blue, float alpha) :
    r(red),
    g(green),
    b(blue),
    a(alpha)
{

}


////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////
bool operator ==(const Color& left, const Color& right)
{
    return (left.r == right.r) &&
           (left.g == right.g) &&
           (left.b == right.b) &&
           (left.a == right.a);
}


////////////////////////////////////////////////////////////
bool operator !=(const Color& left, const Color& right)
{
    return !(left == right);
}


////////////////////////////////////////////////////////////
Color operator +(const Color& left, const Color& right)
{
    return Color(Uint8(std::min((left.r) + right.r, 1.f)),
                 Uint8(std::min((left.g) + right.g, 1.f)),
                 Uint8(std::min((left.b) + right.b, 1.f)),
                 Uint8(std::min((left.a) + right.a, 1.f)));
}


////////////////////////////////////////////////////////////
Color operator -(const Color& left, const Color& right)
{
    return Color(Uint8(std::max((left.r) - right.r, 0.f)),
                 Uint8(std::max((left.g) - right.g, 0.f)),
                 Uint8(std::max((left.b) - right.b, 0.f)),
                 Uint8(std::max((left.a) - right.a, 0.f)));
}


////////////////////////////////////////////////////////////
Color operator *(const Color& left, const Color& right)
{
    return Color(Uint8(int(left.r) * right.r),
                 Uint8(int(left.g) * right.g),
                 Uint8(int(left.b) * right.b),
                 Uint8(int(left.a) * right.a));
}


////////////////////////////////////////////////////////////
Color& operator +=(Color& left, const Color& right)
{
    return left = left + right;
}


////////////////////////////////////////////////////////////
Color& operator -=(Color& left, const Color& right)
{
    return left = left - right;
}


////////////////////////////////////////////////////////////
Color& operator *=(Color& left, const Color& right)
{
    return left = left * right;
}

} // namespace sf
