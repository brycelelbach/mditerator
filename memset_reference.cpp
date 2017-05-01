#include <cstddef>

#include "vectorization_and_assumption_hints.hpp"

void memset_reference(
    std::ptrdiff_t N
  , std::ptrdiff_t M
  , double* __restrict__ A
    )
{
    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);

    BOOST_DEMAND_VECTORIZATION
    for (std::ptrdiff_t j = 0; j != M; ++j)
        BOOST_DEMAND_VECTORIZATION
        for (std::ptrdiff_t i = 0; i != N; ++i)
            A[i + j * N] = 0.0F;
}

