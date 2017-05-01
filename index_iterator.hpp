///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015-7 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

#if !defined(BOOST_56CF02FC_98A3_42C6_B30A_01BE4B03A259)
#define BOOST_56CF02FC_98A3_42C6_B30A_01BE4B03A259

#include "space.hpp"

struct index_2d_iterator
{
    using index_type = position_2d::index_type; 

    struct sentinel
    {
        using index_type = position_2d::index_type; 

        constexpr sentinel(index_type nj_) noexcept : nj(nj_) {}

        index_type nj;
    };

    constexpr index_2d_iterator(dimension_2d i_, dimension_2d j_) noexcept
      : i(i_), j(j_)
    {}

    constexpr index_2d_iterator& operator++() noexcept
    {
        BOOST_ASSUME(i.idx    >= 0);
        BOOST_ASSUME(i.extent >  0);

        ++i.idx;                // Inner loop iteration-expression.

        if (i.extent == i.idx)  // Inner loop condition.
        {
            ++j.idx;            // Outer loop increment.
            i.idx = 0;          // Inner loop init-statement.
        }

        return *this;
    }

    // NOTE: ICPC requries this when we use an iterator-sentinel range.
    friend constexpr index_type operator-(
        index_2d_iterator const& l
      , sentinel r
        ) noexcept
    {
        BOOST_ASSUME(l.i.idx    >= 0);
        BOOST_ASSUME(l.j.idx    >= 0);
        BOOST_ASSUME(l.i.extent >  0);
        BOOST_ASSUME(r.nj       >  0);

        return (r.nj - l.j.idx) * (l.i.extent) - (l.i.extent - l.i.idx);
    }
    friend constexpr index_type operator-(
        sentinel l
      , index_2d_iterator const& r
        ) noexcept
    {
        return (r - l);
    }

    // NOTE: ICPC requries this when we use an iterator-sentinel range.
    constexpr index_2d_iterator& operator+=(
        index_type d
        ) noexcept
    {
        // FIXME: This could be optimized.
        for (index_type x = 0; x != d; ++x)
            ++(*this);

        return *this;
    }

    constexpr position_2d operator*() const noexcept { return {i.idx, j.idx}; }

    friend constexpr bool
    operator==(index_2d_iterator const& l, index_2d_iterator const& r) noexcept
    {
        BOOST_ASSUME(l.i.idx    >= 0);
        BOOST_ASSUME(r.i.idx    >= 0);
        BOOST_ASSUME(l.j.idx    >= 0);
        BOOST_ASSUME(r.j.idx    >= 0);
        BOOST_ASSUME(l.i.extent >  0);
        BOOST_ASSUME(r.i.extent >  0);
        BOOST_ASSUME(l.j.extent >  0);
        BOOST_ASSUME(r.j.extent >  0);

        return l.i.extent == r.i.extent && l.j.extent == r.j.extent
            && l.i.idx    == r.i.idx    && l.j.idx    == r.j.idx;
    }
    friend constexpr bool operator!=(
        index_2d_iterator const& l
      , index_2d_iterator const& r
        ) noexcept
    {
        return !(l == r);
    }

    friend constexpr bool operator==(
        index_2d_iterator const& l
      , sentinel r
        ) noexcept
    {
        BOOST_ASSUME(l.j.idx >= 0);
        BOOST_ASSUME(r.nj    >  0);

        return l.j.idx == r.nj;
    }
    friend constexpr bool operator!=(
        index_2d_iterator const& l
      , sentinel r
        ) noexcept
    {
        return !(l == r);
    }

  private:
    dimension_2d i;
    dimension_2d j;
};

struct index_2d_iterator_sentinel_range
{
    using index_type = position_2d::index_type; 

    constexpr index_2d_iterator_sentinel_range(
        index_type ni
      , index_type nj
        ) noexcept
      : first{dimension_2d{ni, 0}, dimension_2d{nj, 0}}, last{nj}
    {}

    constexpr index_2d_iterator begin() const noexcept { return first; }

    constexpr index_2d_iterator::sentinel end() const noexcept { return last; }

  private:
    index_2d_iterator first;
    index_2d_iterator::sentinel last;
};

#endif // BOOST_56CF02FC_98A3_42C6_B30A_01BE4B03A259

