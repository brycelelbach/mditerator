#include <cstddef>
#include <vector>

#include "vectorization_and_assumption_hints.hpp"
#include "index_generator.hpp"

void stream_triad_index_generator(
    index_type                 N
  , index_type                 M
  , std::vector<double>&       vA
  , std::vector<double> const& vB
  , double                     q
  , std::vector<double> const& vC 
    )
{
    double*       __restrict__ A = vA.data();
    double const* __restrict__ B = vB.data();
    double const* __restrict__ C = vC.data();

    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);
    BOOST_ASSUME_ALIGNED(B, 32);
    BOOST_ASSUME_ALIGNED(C, 32);

    BOOST_DEMAND_VECTORIZATION
    for (auto pos : index_2d_generator::generate(N, M))
        A[pos.i + pos.j * N] = B[pos.i + pos.j * N] + q * C[pos.i + pos.j * N];
}

