///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015-7 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

#if !defined(BOOST_B107541B_3A73_495D_B9BB_F627001CF0F9)
#define BOOST_B107541B_3A73_495D_B9BB_F627001CF0F9

#include <array>
#include <cstddef>

using index_type = std::ptrdiff_t; // Signed 4 life.

template <std::size_t N>
struct position
{
    constexpr position() noexcept : idxs{{}} {}

    template <typename... Idxs>
    constexpr position(Idxs... idxs_) noexcept
      : idxs{{static_cast<index_type>(idxs_)...}}
    {
        static_assert(
            sizeof...(Idxs) == N
          , "Insufficient index parameters to constructor."
        );
    }

    constexpr position(position const&)            noexcept = default;
    constexpr position(position&&)                 noexcept = default;
    constexpr position& operator=(position const&) noexcept = default;
    constexpr position& operator=(position&&)      noexcept = default;

    constexpr index_type& operator[](index_type i) noexcept
    {
        return idxs[i];
    }
    constexpr index_type const& operator[](index_type i) const noexcept
    {
        return idxs[i];
    }

    std::array<index_type, N> idxs;
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

