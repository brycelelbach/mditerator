///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015-7 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

#if !defined(BOOST_56CF02FC_98A3_42C6_B30A_01BE4B03A259)
#define BOOST_56CF02FC_98A3_42C6_B30A_01BE4B03A259

#include "space.hpp"
#include "vectorization_and_assumption_hints.hpp"

struct index_2d_iterator
{
    struct sentinel
    {
        constexpr sentinel(index_type nj_) noexcept : nj(nj_) {}

        index_type nj;
    };

    constexpr index_2d_iterator(dimension i_, dimension j_) noexcept
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
      , index_2d_iterator const& r
        ) noexcept
    {
        BOOST_ASSUME(l.i.idx    >= 0);
        BOOST_ASSUME(r.i.idx    >= 0);
        BOOST_ASSUME(l.j.idx    >= 0);
        BOOST_ASSUME(r.j.idx    >= 0);
        BOOST_ASSUME(l.i.extent >  0);
        BOOST_ASSUME(l.j.extent >  0);

        return (l.j.idx - r.j.idx) * (l.i.extent) - (l.i.idx - r.i.idx);
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

        return (l.j.idx - r.nj) * (l.i.extent) - (l.i.idx - l.i.extent);
    }
    friend constexpr index_type operator-(
        sentinel r
      , index_2d_iterator const& l
        ) noexcept
    {
        BOOST_ASSUME(l.i.idx    >= 0);
        BOOST_ASSUME(l.j.idx    >= 0);
        BOOST_ASSUME(l.i.extent >  0);
        BOOST_ASSUME(r.nj       >  0);

        return (r.nj - l.j.idx) * (l.i.extent) - (l.i.extent - l.i.idx);
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

    constexpr position_2d operator*() const noexcept
    {
        return position_2d(i.idx, j.idx);
    }

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
    dimension i;
    dimension j;
};

constexpr index_2d_iterator index_2d_iterator_begin(
    index_type ni
  , index_type nj
    ) noexcept
{
    return index_2d_iterator(dimension(ni, 0), dimension(nj, 0));
}

constexpr index_2d_iterator index_2d_iterator_end(
    index_type ni
  , index_type nj
    ) noexcept
{
    return index_2d_iterator(dimension(ni, 0), dimension(nj, nj));
}

struct index_2d_iterator_sentinel_range
{
    constexpr index_2d_iterator_sentinel_range(
        index_type ni
      , index_type nj
        ) noexcept
      : first(index_2d_iterator_begin(ni, nj)), last(nj)
    {}

    constexpr index_2d_iterator begin() const noexcept { return first; }

    constexpr index_2d_iterator::sentinel end() const noexcept { return last; }

  private:
    index_2d_iterator first;
    index_2d_iterator::sentinel last;
};

#endif // BOOST_56CF02FC_98A3_42C6_B30A_01BE4B03A259

