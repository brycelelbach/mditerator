#include <cstddef>
#include <vector>

#include "vectorization_and_assumption_hints.hpp"
#include "index_generator.hpp"

void memset_index_generator(
    std::ptrdiff_t N
  , std::ptrdiff_t M
  , std::vector<double>& vA
    )
{
    double* __restrict__ A = vA.data();

    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);

    BOOST_DEMAND_VECTORIZATION
    for (auto pos : index_2d_generator::generate(N, M))
        A[pos.i + pos.j * N] = 0.0F;
}

