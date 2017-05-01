// http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.218.3913&rep=rep1&type=pdf
// http://www.mas.ncl.ac.uk/~n9405169/heat.html

#include <cstddef>

#include "vectorization_and_assumption_hints.hpp"
#include "space.hpp"

void stencil_3d_7point_reference(
    index_type                 N
  , index_type                 M
  , index_type                 P
  , double const* __restrict__ A
  , double*       __restrict__ B
  , double                     c0
  , double                     c1
    ) noexcept
{
    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME((P % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);
    BOOST_ASSUME_ALIGNED(B, 32);

    BOOST_DEMAND_VECTORIZATION
    for (index_type k = 0; k != P; ++k)
        BOOST_DEMAND_VECTORIZATION
        for (index_type j = 0; j != M; ++j)
            BOOST_DEMAND_VECTORIZATION
            for (index_type i = 0; i != N; ++i)
                B[(i) + (j) * N + (k) * N * M]
                    = c0 * A[(i)     + (j)     * N + (k)     * N * M]
                    + c1 * (
                           A[(i - 1) + (j)     * N + (k)     * N * M]
                         + A[(i + 1) + (j)     * N + (k)     * N * M]
                         + A[(i)     + (j - 1) * N + (k)     * N * M]
                         + A[(i)     + (j + 1) * N + (k)     * N * M]
                         + A[(i)     + (j)     * N + (k - 1) * N * M]
                         + A[(i)     + (j)     * N + (k + 1) * N * M]
                           );
}

