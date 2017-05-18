#include <cstddef>
#include <vector>

#include "vectorization_and_assumption_hints.hpp"
#include "index_generator.hpp"

void matrix_multiply_index_generator(
    index_type                 N
  , index_type                 M
  , index_type                 P
  , std::vector<double const>& vA  // A[N][P]
  , std::vector<double const>& vB  // B[P][M]
  , std::vector<double>&       vAB // AB[N][M] = A[N][P] * B[P][M]
    ) noexcept
{
    double const* __restrict__ A  = vA.data();
    double const* __restrict__ B  = vB.data();
    double*       __restrict__ AB = vAB.data();

    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME((P % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);
    BOOST_ASSUME_ALIGNED(B, 32);
    BOOST_ASSUME_ALIGNED(AB, 32);

    BOOST_DEMAND_VECTORIZATION
    for (auto pos : generate_indices(N, P, M))
    {
        index_type const i = pos[0];
        index_type const j = pos[1];
        index_type const k = pos[2];
        AB[i + j * N] += A[i + k * N] * B[k + j * P];
    }
}

