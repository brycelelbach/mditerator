#include <vector>
#include <string>
#include <iostream>

#include "index_generator.hpp"

int main()
{
    std::cout << "Testing index_2d_generator:\n"; 
    // [a00 a01 a02]
    // [a10 a11 a12]

    std::vector<std::string> d = {"a00", "a10", "a01", "a11", "a02", "a12"};

    BOOST_PREVENT_VECTORIZATION
    for (auto pos : index_2d_generator::generate(2, 3))
    {
        std::cout << "(" << pos[0] << " " << pos[1] << ") : "
                  << d[pos[0] + pos[1] * 2]
                  << std::endl;
    }
}

