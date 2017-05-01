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

struct index_2d_generator
{
    struct promise_type
    {
        using return_type = index_2d_generator;

        position_2d pos;

        constexpr std::experimental::suspend_always yield_value(position_2d pos_)
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

        index_2d_generator get_return_object() noexcept
        {
            return index_2d_generator(this);
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

        position_2d operator*() const
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

    static index_2d_generator generate(index_type ni, index_type nj) noexcept
    {
        BOOST_ASSUME(nj > 0);
        BOOST_ASSUME(ni > 0);
        for (index_type j = 0; j != nj; ++j)
            for (index_type i = 0; i != ni; ++i)
                co_yield position_2d(i, j);
    }

    constexpr index_2d_generator(index_2d_generator&& rhs) noexcept
      : p(rhs.p)
    {
        rhs.p = nullptr;
    }

    ~index_2d_generator()
    {
        if (p) p.destroy();
    }

  private:
    explicit index_2d_generator(promise_type* p) noexcept
      : p(std::experimental::coroutine_handle<promise_type>::from_promise(*p))
    {}

    std::experimental::coroutine_handle<promise_type> p;
};

#endif // BOOST_76C43BA7_4B65_455D_AE67_59D1A1D11560

