#include <cstddef>

#include "vectorization_and_assumption_hints.hpp"
#include "space.hpp"

void matrix_multiply_reference(
    index_type                 N
  , index_type                 M
  , index_type                 P
  , double const* __restrict__ A  // A[N][P]
  , double const* __restrict__ B  // B[P][M]
  , double*       __restrict__ AB // AB[N][M] = A[N][P] * B[P][M]
    ) noexcept
{
    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME((P % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);
    BOOST_ASSUME_ALIGNED(B, 32);
    BOOST_ASSUME_ALIGNED(AB, 32);

    BOOST_DEMAND_VECTORIZATION
    for (index_type j = 0; j != M; ++j)
        BOOST_DEMAND_VECTORIZATION
        for (index_type k = 0; k != P; ++k)
            BOOST_DEMAND_VECTORIZATION
            for (index_type i = 0; i != N; ++i)
                AB[i + j * N] += A[i + k * N] * B[k + j * P];
}

