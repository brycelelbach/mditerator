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

static index_generator<1> generate_indices(
    index_type ni
    ) noexcept
{
    BOOST_ASSUME(ni > 0);
    for (index_type i = 0; i != ni; ++i)
        co_yield position<1>(i);
}

static index_generator<2> generate_indices(
    index_type ni
  , index_type nj
    ) noexcept
{
    BOOST_ASSUME(nj > 0);
    BOOST_ASSUME(ni > 0);
    for (index_type j = 0; j != nj; ++j)
        for (index_type i = 0; i != ni; ++i)
            co_yield position<2>(i, j);
}

static index_generator<3> generate_indices(
    index_type ni
  , index_type nj
  , index_type nk
    ) noexcept
{
    BOOST_ASSUME(nk > 0);
    BOOST_ASSUME(nj > 0);
    BOOST_ASSUME(ni > 0);
    for (index_type k = 0; k != nk; ++k)
        for (index_type j = 0; j != nj; ++j)
            for (index_type i = 0; i != ni; ++i)
                co_yield position<3>(i, j, k);
}

static index_generator<4> generate_indices(
    index_type ni
  , index_type nj
  , index_type nk
  , index_type nl
    ) noexcept
{
    BOOST_ASSUME(nl > 0);
    BOOST_ASSUME(nk > 0);
    BOOST_ASSUME(nj > 0);
    BOOST_ASSUME(ni > 0);
    for (index_type l = 0; l != nl; ++l)
        for (index_type k = 0; k != nk; ++k)
            for (index_type j = 0; j != nj; ++j)
                for (index_type i = 0; i != ni; ++i)
                    co_yield position<4>(i, j, k, l);
}

static index_generator<5> generate_indices(
    index_type ni
  , index_type nj
  , index_type nk
  , index_type nl
  , index_type nm
    ) noexcept
{
    BOOST_ASSUME(nm > 0);
    BOOST_ASSUME(nl > 0);
    BOOST_ASSUME(nk > 0);
    BOOST_ASSUME(nj > 0);
    BOOST_ASSUME(ni > 0);
    for (index_type m = 0; m != nm; ++m)
        for (index_type l = 0; l != nl; ++l)
            for (index_type k = 0; k != nk; ++k)
                for (index_type j = 0; j != nj; ++j)
                    for (index_type i = 0; i != ni; ++i)
                        co_yield position<5>(i, j, k, l, m);
}

static index_generator<6> generate_indices(
    index_type ni
  , index_type nj
  , index_type nk
  , index_type nl
  , index_type nm
  , index_type nn
    ) noexcept
{
    BOOST_ASSUME(nn > 0);
    BOOST_ASSUME(nm > 0);
    BOOST_ASSUME(nl > 0);
    BOOST_ASSUME(nk > 0);
    BOOST_ASSUME(nj > 0);
    BOOST_ASSUME(ni > 0);
    for (index_type n = 0; n != nn; ++n)
        for (index_type m = 0; m != nm; ++m)
            for (index_type l = 0; l != nl; ++l)
                for (index_type k = 0; k != nk; ++k)
                    for (index_type j = 0; j != nj; ++j)
                        for (index_type i = 0; i != ni; ++i)
                            co_yield position<6>(i, j, k, l, m, n);
}

#endif // BOOST_76C43BA7_4B65_455D_AE67_59D1A1D11560

