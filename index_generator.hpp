///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015-7 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

#if !defined(BOOST_76C43BA7_4B65_455D_AE67_59D1A1D11560)
#define BOOST_76C43BA7_4B65_455D_AE67_59D1A1D11560

#include "space.hpp"
#include "vectorization_and_assumption_hints.hpp"
#include "coroutine_ts_support_library.hpp"

template <std::size_t N>
struct index_generator
{
    static_assert(N != 0, "N must be greater than 0.");

    struct promise_type
    {
        using return_type = index_generator;

        position<N> pos;

        constexpr std::experimental::suspend_always yield_value(position<N> pos_)
            noexcept
        {
            pos = pos_;
            return {};
        }

        constexpr std::experimental::suspend_always initial_suspend() const
            noexcept
        {
            return {};
        }

        constexpr std::experimental::suspend_always final_suspend() const
            noexcept
        {
            return {};
        }

        index_generator get_return_object() noexcept
        {
            return index_generator(this);
        }

        constexpr void return_void() noexcept {}
    };

    struct iterator
    {
        std::experimental::coroutine_handle<promise_type> coro;
        bool done;

        constexpr iterator(
            std::experimental::coroutine_handle<promise_type> coro_
          , bool done_
            )
          : coro(coro_), done(done_)
        {}

        iterator& operator++()
        {
            coro.resume();
            done = coro.done();
            return *this;
        }

        position<N> operator*() const
        {
            return coro.promise().pos;
        }

        constexpr bool operator==(iterator const& rhs) const noexcept
        {
            return done == rhs.done;
        }
        constexpr bool operator!=(iterator const& rhs) const noexcept
        {
            return !(*this == rhs);
        }
    };

    iterator begin()
    {
        p.resume();
        return iterator(p, p.done());
    }

    constexpr iterator end()
    {
        return iterator(p, true);
    }

    constexpr index_generator(index_generator&& rhs) noexcept
      : p(rhs.p)
    {
        rhs.p = nullptr;
    }

    ~index_generator()
    {
        if (p) p.destroy();
    }

  private:
    explicit index_generator(promise_type* p) noexcept
      : p(std::experimental::coroutine_handle<promise_type>::from_promise(*p))
    {}

    std::experimental::coroutine_handle<promise_type> p;
};

inline static index_generator<1> generate_indices(
    position<2> ni
    ) noexcept
{
    index_type const nilo = ni[0];
    index_type const nihi = ni[1];
    BOOST_ASSUME(nilo >= 0);
    BOOST_ASSUME(nihi >  nilo);
    for (index_type i = nilo; i != nihi; ++i)
        co_yield position<1>(i);
}

inline static index_generator<1> generate_indices(
    index_type ni
    ) noexcept
{
    return generate_indices({0, ni});
}

inline static index_generator<2> generate_indices(
    position<2> ni
  , position<2> nj
    ) noexcept
{
    index_type const nilo = ni[0];
    index_type const nihi = ni[1];
    index_type const njlo = nj[0];
    index_type const njhi = nj[1];
    BOOST_ASSUME(njlo >= 0);
    BOOST_ASSUME(nilo >= 0);
    BOOST_ASSUME(njhi >  njlo);
    BOOST_ASSUME(nihi >  nilo);
    for (index_type j = njlo; j != njhi; ++j)
        for (index_type i = nilo; i != nihi; ++i)
            co_yield position<2>(i, j);
}

inline static index_generator<2> generate_indices(
    index_type ni
  , index_type nj
    ) noexcept
{
    return generate_indices({0, ni}, {0, nj});
}

inline static index_generator<3> generate_indices(
    position<2> ni
  , position<2> nj
  , position<2> nk
    ) noexcept
{
    index_type const nilo = ni[0];
    index_type const nihi = ni[1];
    index_type const njlo = nj[0];
    index_type const njhi = nj[1];
    index_type const nklo = nk[0];
    index_type const nkhi = nk[1];
    BOOST_ASSUME(nklo >= 0);
    BOOST_ASSUME(njlo >= 0);
    BOOST_ASSUME(nilo >= 0);
    BOOST_ASSUME(nkhi >  nklo);
    BOOST_ASSUME(njhi >  njlo);
    BOOST_ASSUME(nihi >  nilo);
    for (index_type k = nklo; k != nkhi; ++k)
        for (index_type j = njlo; j != njhi; ++j)
            for (index_type i = nilo; i != nihi; ++i)
                co_yield position<3>(i, j, k);
}

inline static index_generator<3> generate_indices(
    index_type ni
  , index_type nj
  , index_type nk
    ) noexcept
{
    return generate_indices({0, ni}, {0, nj}, {0, nk});
}

inline static index_generator<4> generate_indices(
    position<2> ni
  , position<2> nj
  , position<2> nk
  , position<2> nl
    ) noexcept
{
    index_type const nilo = ni[0];
    index_type const nihi = ni[1];
    index_type const njlo = nj[0];
    index_type const njhi = nj[1];
    index_type const nklo = nk[0];
    index_type const nkhi = nk[1];
    index_type const nllo = nl[0];
    index_type const nlhi = nl[1];
    BOOST_ASSUME(nllo >= 0);
    BOOST_ASSUME(nklo >= 0);
    BOOST_ASSUME(njlo >= 0);
    BOOST_ASSUME(nilo >= 0);
    BOOST_ASSUME(nlhi >  nllo);
    BOOST_ASSUME(nkhi >  nklo);
    BOOST_ASSUME(njhi >  njlo);
    BOOST_ASSUME(nihi >  nilo);
    for (index_type l = nllo; l != nlhi; ++l)
        for (index_type k = nklo; k != nkhi; ++k)
            for (index_type j = njlo; j != njhi; ++j)
                for (index_type i = nilo; i != nihi; ++i)
                    co_yield position<4>(i, j, k, l);
}

inline static index_generator<4> generate_indices(
    index_type ni
  , index_type nj
  , index_type nk
  , index_type nl
    ) noexcept
{
    return generate_indices({0, ni}, {0, nj}, {0, nk}, {0, nl});
}

inline static index_generator<5> generate_indices(
    position<2> ni
  , position<2> nj
  , position<2> nk
  , position<2> nl
  , position<2> nm
    ) noexcept
{
    index_type const nilo = ni[0];
    index_type const nihi = ni[1];
    index_type const njlo = nj[0];
    index_type const njhi = nj[1];
    index_type const nklo = nk[0];
    index_type const nkhi = nk[1];
    index_type const nllo = nl[0];
    index_type const nlhi = nl[1];
    index_type const nmlo = nm[0];
    index_type const nmhi = nm[1];
    BOOST_ASSUME(nmlo >= 0);
    BOOST_ASSUME(nllo >= 0);
    BOOST_ASSUME(nklo >= 0);
    BOOST_ASSUME(njlo >= 0);
    BOOST_ASSUME(nilo >= 0);
    BOOST_ASSUME(nmhi >  nmlo);
    BOOST_ASSUME(nlhi >  nllo);
    BOOST_ASSUME(nkhi >  nklo);
    BOOST_ASSUME(njhi >  njlo);
    BOOST_ASSUME(nihi >  nilo);
    for (index_type m = nmlo; m != nmhi; ++m)
        for (index_type l = nllo; l != nlhi; ++l)
            for (index_type k = nklo; k != nkhi; ++k)
                for (index_type j = njlo; j != njhi; ++j)
                    for (index_type i = nilo; i != nihi; ++i)
                        co_yield position<5>(i, j, k, l, m);
}

inline static index_generator<5> generate_indices(
    index_type ni
  , index_type nj
  , index_type nk
  , index_type nl
  , index_type nm
    ) noexcept
{
    return generate_indices({0, ni}, {0, nj}, {0, nk}, {0, nl}, {0, nm});
}

inline static index_generator<6> generate_indices(
    position<2> ni
  , position<2> nj
  , position<2> nk
  , position<2> nl
  , position<2> nm
  , position<2> nn
    ) noexcept
{
    index_type const nilo = ni[0];
    index_type const nihi = ni[1];
    index_type const njlo = nj[0];
    index_type const njhi = nj[1];
    index_type const nklo = nk[0];
    index_type const nkhi = nk[1];
    index_type const nllo = nl[0];
    index_type const nlhi = nl[1];
    index_type const nmlo = nm[0];
    index_type const nmhi = nm[1];
    index_type const nnlo = nn[0];
    index_type const nnhi = nn[1];
    BOOST_ASSUME(nnlo >= 0);
    BOOST_ASSUME(nmlo >= 0);
    BOOST_ASSUME(nllo >= 0);
    BOOST_ASSUME(nklo >= 0);
    BOOST_ASSUME(njlo >= 0);
    BOOST_ASSUME(nilo >= 0);
    BOOST_ASSUME(nnhi >  nnlo);
    BOOST_ASSUME(nmhi >  nmlo);
    BOOST_ASSUME(nlhi >  nllo);
    BOOST_ASSUME(nkhi >  nklo);
    BOOST_ASSUME(njhi >  njlo);
    BOOST_ASSUME(nihi >  nilo);
    for (index_type n = nnlo; n != nnhi; ++n)
        for (index_type m = nmlo; m != nmhi; ++m)
            for (index_type l = nllo; l != nlhi; ++l)
                for (index_type k = nklo; k != nkhi; ++k)
                    for (index_type j = njlo; j != njhi; ++j)
                        for (index_type i = nilo; i != nihi; ++i)
                            co_yield position<6>(i, j, k, l, m, n);
}

inline static index_generator<6> generate_indices(
    index_type ni
  , index_type nj
  , index_type nk
  , index_type nl
  , index_type nm
  , index_type nn
    ) noexcept
{
    return generate_indices({0, ni}, {0, nj}, {0, nk}, {0, nl}, {0, nm}, {0, nn});
}

#endif // BOOST_76C43BA7_4B65_455D_AE67_59D1A1D11560

