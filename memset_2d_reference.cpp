#include <cstddef>

#include "vectorization_and_assumption_hints.hpp"
#include "space.hpp"

void memset_2d_reference(
    index_type           N
  , index_type           M
  , double* __restrict__ A
    ) noexcept
{
    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);

    BOOST_DEMAND_VECTORIZATION
    for (index_type j = 0; j != M; ++j)
        BOOST_DEMAND_VECTORIZATION
        for (index_type i = 0; i != N; ++i)
            A[i + j * N] = 0.0F;
}

