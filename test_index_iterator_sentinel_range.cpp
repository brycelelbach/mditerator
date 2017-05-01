#include <vector>
#include <string>
#include <iostream>

#include "index_iterator.hpp"

int main()
{
    std::cout << "Testing index_2d_iterator_sentinel_range:\n";

    // [a00 a01 a02]
    // [a10 a11 a12]

    std::vector<std::string> d = {"a00", "a10", "a01", "a11", "a02", "a12"};

    auto&& r   = index_2d_iterator_sentinel_range(2, 3);
    auto first = r.begin();
    auto last  = r.end();

    BOOST_PREVENT_VECTORIZATION
    for (; first != last; ++first)
    {
        auto pos = *first;
        std::cout << "(" << pos.i << " " << pos.j << ") : "
                  << d[pos.i + pos.j * 2]
                  << "\n";
    }
}

