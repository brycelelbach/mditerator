///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2017 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
// Copyright (c) 2017 Gor Nishanov
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

#include <vector>
#include <iostream>

#if (  defined(MEMSET_INDEX_GENERATOR)                                        \
    || defined(STREAM_TRIAD_INDEX_GENERATOR))                                  \
 && !defined(INDEX_GENERATOR)
    #define INDEX_GENERATOR
#endif

#if (  defined(MEMSET_INDEX_ITERATOR)                                        \
    || defined(STREAM_TRIAD_INDEX_ITERATOR))                                  \
 && !defined(INDEX_ITERATOR)
    #define INDEX_ITERATOR
#endif

#include "vectorization_and_assumption_hints.hpp"

///////////////////////////////////////////////////////////////////////////////

#if defined(INDEX_GENERATOR)
    #include "libcxx_restrict_pointer_iterator_traits.hpp"
#endif

///////////////////////////////////////////////////////////////////////////////

#if   defined(INDEX_GENERATOR)
    #include "index_generator.hpp"
#elif defined(INDEX_ITERATOR)
    #include "index_iterator.hpp"
#endif

#if defined(MEMSET_INDEX_GENERATOR)
void memset_generator_NN(
    std::ptrdiff_t N
  , std::vector<double>& vA
    )
{
    double* __restrict__ A = vA.data();

    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);

    BOOST_DEMAND_VECTORIZATION
    for (auto pos : index_2d_generator::generate(N, N))
        A[pos.i + pos.j * N] = 0.0F;
}

void memset_generator_NM(
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
#endif

#if defined(STREAM_TRIAD_INDEX_GENERATOR)
void stream_triad(
    std::ptrdiff_t N
  , std::vector<double>& vA
  , std::vector<double> const& vB
  , double q
  , std::vector<double> const& vC 
    )
{
    double*       __restrict__ A = vA.data();
    double const* __restrict__ B = vB.data();
    double const* __restrict__ C = vC.data();

    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);
    BOOST_ASSUME_ALIGNED(B, 32);
    BOOST_ASSUME_ALIGNED(C, 32);

    BOOST_DEMAND_VECTORIZATION
    for (auto pos : index_2d_generator::generate(N, N))
        A[pos.i + pos.j * N] = B[pos.i + pos.j * N] + q * C[pos.i + pos.j * N];
}
#endif

#if defined(MEMSET_INDEX_ITERATOR)
void memset_index_iterator_sentinel_range_NN(
    std::ptrdiff_t N
  , std::vector<double>& vA
    )
{
    double* __restrict__ A = vA.data();

    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);
   
    auto&& r   = index_2d_iterator_sentinel_range{N, N};
    auto first = r.begin();
    auto last  = r.end();

    BOOST_DEMAND_VECTORIZATION
    for (; first != last; ++first)
    {
        auto pos = *first;
        A[pos.i + pos.j * N] = 0.0F;
    }
}

void memset_index_iterator_sentinel_range_NM(
    std::ptrdiff_t N
  , std::ptrdiff_t M
  , std::vector<double>& vA
    )
{
    double* __restrict__ A = vA.data();

    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);
   
    auto&& r   = index_2d_iterator_sentinel_range{N, M};
    auto first = r.begin();
    auto last  = r.end();

    BOOST_DEMAND_VECTORIZATION
    for (; first != last; ++first)
    {
        auto pos = *first;
        A[pos.i + pos.j * N] = 0.0F;
    }
}
#endif

#if defined(MEMSET_LOOP)
void memset_loop_NN(
    std::ptrdiff_t N
  , double* __restrict__ A
    )
{
    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);

    for (std::ptrdiff_t j = 0; j != N; ++j)
        BOOST_DEMAND_VECTORIZATION
        for (std::ptrdiff_t i = 0; i != N; ++i)
            A[i + j * N] = 0.0F; 
}

void memset_loop_NM(
    std::ptrdiff_t N
  , std::ptrdiff_t M
  , double* __restrict__ A
    )
{
    BOOST_ASSUME((N % 32) == 0);
    BOOST_ASSUME((M % 32) == 0);
    BOOST_ASSUME_ALIGNED(A, 32);

    for (std::ptrdiff_t j = 0; j != M; ++j)
        BOOST_DEMAND_VECTORIZATION
        for (std::ptrdiff_t i = 0; i != N; ++i)
            A[i + j * N] = 0.0F;
}
#endif

#if defined(TEST)
int main()
{
    #if defined(MEMSET_INDEX_GENERATOR)
    {
        std::cout << "\nTesting index_2d_generator:\n";

        // [a00 a01 a02]
        // [a10 a11 a12]

        std::vector<std::string> d = {"a00", "a10", "a01", "a11", "a02", "a12"};

        for (auto pos : index_2d_generator::generate(2, 3))
        {
            std::cout << "(" << pos.i << " " << pos.j << ") : "
                      << d[pos.i + pos.j * 2]
                      << std::endl;
        }
    }
    #endif

    #if defined(MEMSET_INDEX_ITERATOR)
    {
        std::cout << "\nTesting index_2d_iterator_sentinel_range:\n";

        // [a00 a01 a02]
        // [a10 a11 a12]

        std::vector<std::string> d = {"a00", "a10", "a01", "a11", "a02", "a12"};

        auto&& r   = index_2d_iterator_sentinel_range{2, 3};
        auto first = r.begin();
        auto last  = r.end();

        BOOST_DEMAND_VECTORIZATION
        for (; first != last; ++first)
        {
            auto pos = *first;
            std::cout << "(" << pos.i << " " << pos.j << ") : "
                      << d[pos.i + pos.j * 2]
                      << "\n";
        }
    }
    #endif
}
#endif

