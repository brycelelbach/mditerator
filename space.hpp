///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015-7 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

#if !defined(BOOST_B107541B_3A73_495D_B9BB_F627001CF0F9)
#define BOOST_B107541B_3A73_495D_B9BB_F627001CF0F9

#include <cstddef>

using index_type = std::ptrdiff_t; // Signed 4 life.

struct position_2d
{
    constexpr position_2d() noexcept : i(0), j(0) {}

    constexpr position_2d(index_type i_, index_type j_) noexcept
      : i(i_), j(j_)
    {}

    constexpr position_2d(position_2d const&)            noexcept = default;
    constexpr position_2d(position_2d&&)                 noexcept = default;
    constexpr position_2d& operator=(position_2d const&) noexcept = default;
    constexpr position_2d& operator=(position_2d&&)      noexcept = default;

    index_type i; // Inner loop index.
    index_type j; // Outer loop index.
}; 

struct dimension
{
    constexpr dimension() noexcept : extent(0), idx(0) {}

    constexpr dimension(index_type extent_, index_type idx_) noexcept
      : extent(extent_), idx(idx_)
    {}

    constexpr dimension(dimension const&) noexcept = default;
    constexpr dimension(dimension&&)      noexcept = default;

    index_type const extent;
    index_type       idx;
}; 

#endif // BOOST_B107541B_3A73_495D_B9BB_F627001CF0F9

