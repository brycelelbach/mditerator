// http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.218.3913&rep=rep1&type=pdf
// http://www.mas.ncl.ac.uk/~n9405169/heat.html

#include <cstddef>
#include <vector>

#include "vectorization_and_assumption_hints.hpp"
#include "index_generator.hpp"

void stencil_3d_7point_index_generator(
    index_type                 N
  , index_type                 M
  , index_type                 P
  , std::vector<double> const& vA
  , std::vector<double>&       vB
  , double                     c0
  , double                     c1
    ) noexcept
{
    double const* __restrict__ A = vA.data();
    double*       __restrict__ B = vB.data();

    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME((P % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);
    BOOST_ASSUME_ALIGNED(B, 32);

    BOOST_DEMAND_VECTORIZATION
    for (auto pos : generate_indices(N, M, P))
    {
        index_type const i = pos[0];
        index_type const j = pos[1];
        index_type const k = pos[2];
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
}

