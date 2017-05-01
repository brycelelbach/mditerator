#include <cstddef>
#include <vector>

#include "vectorization_and_assumption_hints.hpp"
#include "index_iterator.hpp"

void memset_index_iterator_sentinel_range(
    index_type N
  , index_type M
  , std::vector<double>& vA
    )
{
    double* __restrict__ A = vA.data();

    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);
   
    auto&& r   = index_2d_iterator_sentinel_range(N, M);
    auto first = r.begin();
    auto last  = r.end();

    BOOST_DEMAND_VECTORIZATION
    for (; first != last; ++first)
    {
        auto pos = *first;
        A[pos.i + pos.j * N] = 0.0F;
    }
}

