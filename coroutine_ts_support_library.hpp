///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015-7 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

// "Portable" implementation of <experimental/coroutine>.

#if !defined(BOOST_9B7B58AE_F9C8_47B8_93E1_ED38A5FBBCB5)
#define BOOST_9B7B58AE_F9C8_47B8_93E1_ED38A5FBBCB5

///////////////////////////////////////////////////////////////////////////////
// <experimental/coroutine> synopsis (Coroutine TS 18.11 [support.coroutine] p1):

namespace std { namespace experimental { inline namespace coroutines_v1
{

// Coroutine traits (Coroutine TS 18.11.1 [coroutine.traits]):
template <typename R, typename... ArgTypes>
struct coroutine_traits;

// Coroutine handle (Coroutine TS 18.11.2 [coroutine.handle]):
template <typename Promise = void>
struct coroutine_handle;

// Comparison operators (Coroutine TS 18.11.2.7 [coroutine.handle.compare]): 
constexpr bool operator==(coroutine_handle<> x, coroutine_handle<> y) noexcept;
constexpr bool operator!=(coroutine_handle<> x, coroutine_handle<> y) noexcept;
constexpr bool operator< (coroutine_handle<> x, coroutine_handle<> y) noexcept;
constexpr bool operator<=(coroutine_handle<> x, coroutine_handle<> y) noexcept;
constexpr bool operator>=(coroutine_handle<> x, coroutine_handle<> y) noexcept;
constexpr bool operator> (coroutine_handle<> x, coroutine_handle<> y) noexcept;

// Trivial awaitables (Coroutine TS 18.11.3 [coroutine.trivial.awaitables]):
struct suspend_never;
struct suspend_always;

///////////////////////////////////////////////////////////////////////////////
// coroutine_traits<R, ArgTypes...> (Coroutine TS 18.11.1 [coroutine.traits]):

// Users are allowed to specialize this trait (Coroutine TS 18.11.1
// [coroutines.traits] p2).

template <typename R, typename... ArgTypes>
struct coroutine_traits
{
    // Technically, if R has no valid member type promise_type, then
    // coroutine_traits<R, ArgTypes...> should have no members (Coroutine TS
    // 18.11.1.1 [coroutine.traits.primary] p1).
    using promise_type = typename R::promise_type;
};

///////////////////////////////////////////////////////////////////////////////
// coroutine_handle<Promise> (Coroutine TS 18.11.2 [coroutine.handle]):

template <>
struct coroutine_handle<void>
{
    ///////////////////////////////////////////////////////////////////////////
    // Construct/reset (Coroutine TS 18.11.2.1 [coroutine.handle.con]):

    // We use decltype(nullptr) instead of nullptr_t to avoid including <cstddef>.

    constexpr coroutine_handle() noexcept : ptr(nullptr) {}
    constexpr coroutine_handle(decltype(nullptr)) noexcept : ptr(nullptr) {}

    coroutine_handle& operator=(decltype(nullptr)) noexcept
    {
        ptr = nullptr;
        return *this;
    }

    ///////////////////////////////////////////////////////////////////////////
    // Export/import (Coroutine TS 18.11.2.2 [coroutine.handle.import.export]):

    constexpr void* address() const noexcept
    {
        return ptr;
    }

    // Preconditions: addr was obtained via a prior call to address.
    constexpr static coroutine_handle from_address(void *addr) 
    {
        coroutine_handle me;
        me.ptr = addr;
        return me;
    }

    ///////////////////////////////////////////////////////////////////////////
    // Observers (Coroutine TS 18.11.2.4 [coroutine.handle.observers]):

    constexpr explicit operator bool() const noexcept
    {
        return ptr;
    }

    // Preconditions: *this refers to a suspended coroutine.
    // 
    // Returns: true if the coroutine is suspended at its final suspend point,
    // otherwise false.
    bool done() const
    {
        return __builtin_coro_done(ptr);
    }

    ///////////////////////////////////////////////////////////////////////////
    // Resumption (Coroutine TS 18.11.2.5 [coroutine.handle.resumption]):

    // Preconditions: *this refers to a suspended coroutine.
    // 
    // Effects: Resumes the execution of the coroutine. If the coroutine was
    // suspended at its final suspend point, behavior is undefined.
    //
    // Synchronization: A concurrent resumption of a coroutine by multiple
    // threads may result in a data race.
    void operator()()
    {
        resume();
    }
    void resume() const
    {
        __builtin_coro_resume(ptr);
    }

    // Preconditions: *this refers to a suspended coroutine.
    // 
    // Effects: Destroys the coroutine.
    // 
    // Synchronization: A concurrent resumption of a coroutine by multiple
    // threads may result in a data race.
    void destroy() const
    {
        __builtin_coro_destroy(ptr);
    }

  protected:
    void *ptr;
};

template <typename Promise>
struct coroutine_handle : coroutine_handle<>
{
    ///////////////////////////////////////////////////////////////////////////
    // Construct/reset (Coroutine TS 18.11.2.1 [coroutine.handle.con]):

    using coroutine_handle<>::coroutine_handle;

    static coroutine_handle from_promise(Promise& promise)
    {
        coroutine_handle p;
        p.ptr = __builtin_coro_promise(&promise, alignof(Promise), true);
        return p;
    }

    using coroutine_handle<>::operator=;

    ///////////////////////////////////////////////////////////////////////////
    // Import (Coroutine TS 18.11.2.2 [coroutine.handle.import.export]):

    // Preconditions: addr was obtained via a prior call to address.
    constexpr static coroutine_handle from_address(void *addr) noexcept
    {
        coroutine_handle me;
        me.ptr = addr;
        return me;
    }

    ///////////////////////////////////////////////////////////////////////////
    // Promise access (Coroutine TS 18.11.2.6 [coroutine.handle.promise]):

    // Preconditions: *this refers to a coroutine.
    //
    // Returns: A reference to the promise of the coroutine.
    Promise& promise() const
    {
        return *reinterpret_cast<Promise*>(
            __builtin_coro_promise(ptr, alignof(Promise), false)
        );
    }
};

///////////////////////////////////////////////////////////////////////////////
// Comparison operators (Coroutine TS 18.11.2.7 [coroutine.handle.compare]):

// constexpr added as an extension.

constexpr bool operator==(coroutine_handle<> x, coroutine_handle<> y) noexcept
{
    return x.address() == y.address();
}

constexpr bool operator!=(coroutine_handle<> x, coroutine_handle<> y) noexcept
{
    return !(x == y); 
}

constexpr bool operator<(coroutine_handle<> x, coroutine_handle<> y) noexcept
{
    // The Coroutine TS says to do less<void*>()(x.address(), y.address()), but
    // I don't want to include anything from this header.
    return x.address() < y.address();
}

constexpr bool operator>(coroutine_handle<> x, coroutine_handle<> y) noexcept
{
    return y < x; 
}

constexpr bool operator<=(coroutine_handle<> x, coroutine_handle<> y) noexcept
{
    return !(x > y); 
}

constexpr bool operator>=(coroutine_handle<> x, coroutine_handle<> y) noexcept
{
    return !(x < y); 
}

///////////////////////////////////////////////////////////////////////////////
// Trivial Awaitables (Coroutine TS 18.11.3 [coroutine.trivial.awaitables]

struct suspend_always
{
    constexpr bool await_ready() const noexcept { return false; }
    constexpr void await_suspend(coroutine_handle<>) const noexcept {}
    constexpr void await_resume() const noexcept {}
};

struct suspend_never
{
    constexpr bool await_ready() const noexcept { return true; }
    constexpr void await_suspend(coroutine_handle<>) const noexcept {}
    constexpr void await_resume() const noexcept {}
};

}}} // namespace std::experimental::coroutines_v1

#endif // BOOST_9B7B58AE_F9C8_47B8_93E1_ED38A5FBBCB5

