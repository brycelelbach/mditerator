///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2017 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
// Copyright (c) 2017 Gor Nishanov
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

#include <vector>
#include <iterator>
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

///////////////////////////////////////////////////////////////////////////////
// "Portable" Bryce-to-vectorizer communication facilities.
// I never leave home without 'em!

// BOOST_PP_STRINGIZE(expr) - Return expr as a string literal.
#define BOOST_PP_STRINGIZE_(expr) #expr
#define BOOST_PP_STRINGIZE(expr) BOOST_PP_STRINGIZE_(expr)

// BOOST_PRAGMA(args) - Emits a pragma.
#define BOOST_PRAGMA(args) _Pragma(BOOST_PP_STRINGIZE(args))

// BOOST_DEMAND_VECTORIZATION - Insist that the compiler disregard loop-carried
// dependency analysis and cost modelling and vectorize the loop directly
// following the macro. Using this incorrectly can silently cause bogus codegen
// that blows up in unexpected ways. Usage:
//
//   BOOST_DEMAND_VECTORIZATION for (/* ... */) { /* ... */ }
//
// NOTE: Unlike Clang and Intel, GCC doesn't have a stronger hint than ivdep,
// so this is the best we can do. It is not clear if this overrides GCC's cost
// modeling.
#if   defined(__INTEL_COMPILER)
    #define BOOST_DEMAND_VECTORIZATION                                         \
        BOOST_PRAGMA(simd)                                                     \
        /**/
#elif defined(__clang__)
    #define BOOST_DEMAND_VECTORIZATION                                         \
        BOOST_PRAGMA(clang loop vectorize(enable) interleave(enable))          \
        /**/
#else
    #define BOOST_DEMAND_VECTORIZATION                                         \
        BOOST_PRAGMA(GCC ivdep)                                                \
        /**/
#endif

// BOOST_BUILTIN_ASSUME(expr) - Tell the compiler to assume that expr is true.
// Useful for telling the compiler that the trip count for a loop is division
// by a unrolling/vectorizing-friendly number:
//
//   BOOST_BUILTIN_ASSUME((N % 32) == 0); for (auto i = 0; i != N; ++i) /* ... */
//
// BOOST_BUILTIN_ASSUME_ALIGNED(ptr, align) - Tell the compiler to
// assume that ptr is aligned to align bytes. ptr must be an lvalue non-const
// pointer.
//
// NOTE: These used to have ridiculous exponential-in-number-of-uses
// compile-time costs with Clang/LLVM. For example, a 10k line project with
// ~100 BOOST_BUILTIN_ASSUME/BOOST_BUILTIN_ASSUME_ALIGNED usages would take ~20
// seconds to build with ICPC and ~5-10 minutes with Clang/LLVM. I believe the
// issue has now been fixed, but you'll run into it with older versions.
// 
// NOTE: To the best of my knowledge, ICPC's __assume_aligned() is an
// assumption about the first argument, while Clang/GCC's
// __builtin_assume_aligned() is an assumption about the return value of the
// intrinsic.
#if   defined(__INTEL_COMPILER)
    #define BOOST_BUILTIN_ASSUME(expr)                                         \
        __assume(expr)                                                         \
        /**/
    #define BOOST_BUILTIN_ASSUME_ALIGNED(ptr, align)                           \
        __assume_aligned(ptr, align)                                           \
        /**/
#elif defined(__clang__)
    #define BOOST_BUILTIN_ASSUME(expr)                                         \
        __builtin_assume(expr)                                                 \
        /**/
    #define BOOST_BUILTIN_ASSUME_ALIGNED(ptr, align)                           \
        {                                                                      \
            ptr = reinterpret_cast<decltype(ptr)>(                             \
                __builtin_assume_aligned(ptr, align)                           \
            );                                                                 \
        }                                                                      \
        /**/
#else // GCC
    #define BOOST_BUILTIN_ASSUME(expr)                                         \
        do { if (!(expr)) __builtin_unreachable(); } while (0)                 \
        /**/
    #define BOOST_BUILTIN_ASSUME_ALIGNED(ptr, align)                           \
        {                                                                      \
            ptr = reinterpret_cast<decltype(ptr)>(                             \
                __builtin_assume_aligned(ptr, align)                           \
            );                                                                 \
        }                                                                      \
        /**/
#endif

///////////////////////////////////////////////////////////////////////////////

#if defined(INDEX_GENERATOR)
namespace std { inline namespace __1 {

template <typename _Tp>
struct iterator_traits<_Tp* __restrict__>
{
    typedef ptrdiff_t difference_type;
    typedef typename remove_const<_Tp>::type value_type;
    typedef _Tp* __restrict__ pointer;
    typedef _Tp& reference;
    typedef random_access_iterator_tag iterator_category;
};

}} // std::__1

///////////////////////////////////////////////////////////////////////////////

// "Portable" implementation of <experimental/coroutine>.

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
#endif

///////////////////////////////////////////////////////////////////////////////

struct position
{
    using index_type = std::ptrdiff_t; // Signed 4 life.

    index_type i; // Inner loop index.
    index_type j; // Outer loop index.
}; 

struct dimension
{
    using index_type = position::index_type; 

    index_type const extent;
    index_type       idx;
}; 

#if defined(INDEX_GENERATOR)
struct index_2d_generator
{
    using index_type = position::index_type; 

    struct promise_type
    {
        using return_type = index_2d_generator;

        position pos;

        constexpr std::experimental::suspend_always yield_value(position pos_)
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
            return index_2d_generator{this};
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

        position operator*() const
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
        return {p, p.done()};
    }

    constexpr iterator end()
    {
        return {p, true};
    }

    static index_2d_generator generate(index_type ni, index_type nj) noexcept
    {
        BOOST_BUILTIN_ASSUME(nj > 0);
        BOOST_BUILTIN_ASSUME(ni > 0);
        for (index_type j = 0; j != nj; ++j)
            for (index_type i = 0; i != ni; ++i)
                co_yield position{i, j};
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
#endif

#if defined(INDEX_ITERATOR)
struct index_2d_iterator
{
    using index_type = position::index_type; 

    struct sentinel
    {
        using index_type = position::index_type; 

        constexpr sentinel(index_type nj_) noexcept : nj(nj_) {}

        index_type nj;
    };

    constexpr index_2d_iterator(dimension i_, dimension j_) noexcept
      : i(i_), j(j_)
    {}

    constexpr index_2d_iterator& operator++() noexcept
    {
        BOOST_BUILTIN_ASSUME(i.idx    >= 0);
        BOOST_BUILTIN_ASSUME(i.extent >  0);

        ++i.idx;                // Inner loop iteration-expression.

        if (i.extent == i.idx)  // Inner loop condition.
        {
            ++j.idx;            // Outer loop increment.
            i.idx = 0;          // Inner loop init-statement.
        }

        return *this;
    }

    // NOTE: For some reason, ICPC wants this.
    friend constexpr index_type operator-(
        index_2d_iterator const& l
      , sentinel r
        ) noexcept
    {
        BOOST_BUILTIN_ASSUME(l.i.idx    >= 0);
        BOOST_BUILTIN_ASSUME(l.j.idx    >= 0);
        BOOST_BUILTIN_ASSUME(l.i.extent >  0);
        BOOST_BUILTIN_ASSUME(r.nj       >  0);

        return (r.nj - l.j.idx) * (l.i.extent) - (l.i.extent - l.i.idx);
    }
    friend constexpr index_type operator-(
        sentinel l
      , index_2d_iterator const& r
        ) noexcept
    {
        return (r - l);
    }

    // NOTE: For some reason, ICPC wants this.
    constexpr index_2d_iterator& operator+=(
        index_type d
        ) noexcept
    {
//        #warning Optimize me!
        for (index_type x = 0; x != d; ++x)
            ++(*this);

        return *this;
    }

    constexpr position operator*() const noexcept { return {i.idx, j.idx}; }

    friend constexpr bool
    operator==(index_2d_iterator const& l, index_2d_iterator const& r) noexcept
    {
        BOOST_BUILTIN_ASSUME(l.i.idx    >= 0);
        BOOST_BUILTIN_ASSUME(r.i.idx    >= 0);
        BOOST_BUILTIN_ASSUME(l.j.idx    >= 0);
        BOOST_BUILTIN_ASSUME(r.j.idx    >= 0);
        BOOST_BUILTIN_ASSUME(l.i.extent >  0);
        BOOST_BUILTIN_ASSUME(r.i.extent >  0);
        BOOST_BUILTIN_ASSUME(l.j.extent >  0);
        BOOST_BUILTIN_ASSUME(r.j.extent >  0);

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
        BOOST_BUILTIN_ASSUME(l.j.idx >= 0);
        BOOST_BUILTIN_ASSUME(r.nj    >  0);

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

struct index_2d_iterator_sentinel_range
{
    using index_type = position::index_type; 

    constexpr index_2d_iterator_sentinel_range(
        index_type ni
      , index_type nj
        ) noexcept
      : first{dimension{ni, 0}, dimension{nj, 0}}, last{nj}
    {}

    constexpr index_2d_iterator begin() const noexcept { return first; }

    constexpr index_2d_iterator::sentinel end() const noexcept { return last; }

  private:
    index_2d_iterator first;
    index_2d_iterator::sentinel last;
};
#endif

#if defined(MEMSET_INDEX_GENERATOR)
void memset_generator_NN(
    std::ptrdiff_t N
  , std::vector<double>& vA
    )
{
    double* __restrict__ A = vA.data();

    BOOST_BUILTIN_ASSUME((N % 32) == 0);
    BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);

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

    BOOST_BUILTIN_ASSUME((N % 32) == 0);
    BOOST_BUILTIN_ASSUME((M % 32) == 0);
    BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);

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

    BOOST_BUILTIN_ASSUME((N % 32) == 0);
    BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);
    BOOST_BUILTIN_ASSUME_ALIGNED(B, 32);
    BOOST_BUILTIN_ASSUME_ALIGNED(C, 32);

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

    BOOST_BUILTIN_ASSUME((N % 32) == 0);
    BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);
   
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

    BOOST_BUILTIN_ASSUME((N % 32) == 0);
    BOOST_BUILTIN_ASSUME((M % 32) == 0);
    BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);
   
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
    BOOST_BUILTIN_ASSUME((N % 32) == 0);
    BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);

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
    BOOST_BUILTIN_ASSUME((N % 32) == 0);
    BOOST_BUILTIN_ASSUME((M % 32) == 0);
    BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);

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

