#include <vector>
#include <string>
#include <iostream>

#include "index_iterator.hpp"

int main()
{
    std::cout << "Testing index_2d_iterator_pair:\n";

    // [a00 a01 a02]
    // [a10 a11 a12]

    std::vector<std::string> d = {"a00", "a10", "a01", "a11", "a02", "a12"};

    auto first = index_2d_iterator_begin(2, 3);
    auto last  = index_2d_iterator_end(2, 3);

    BOOST_PREVENT_VECTORIZATION
    for (; first != last; ++first)
    {
        auto pos = *first;
        std::cout << "(" << pos[0] << " " << pos[1] << ") : "
                  << d[pos[0] + pos[1] * 2]
                  << "\n";
    }
}

