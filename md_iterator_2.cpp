#include <vector>
#include <iterator>
#include <iostream>

#if defined(TRANSFORM_ITERATOR)
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

namespace std { namespace experimental { inline namespace coroutines_v1 {

template <typename R, typename...> struct coroutine_traits {
  using promise_type = typename R::promise_type;
};

template <typename Promise = void> struct coroutine_handle;

template <> struct coroutine_handle<void> {
  static coroutine_handle from_address(void *addr) noexcept {
    coroutine_handle me;
    me.ptr = addr;
    return me;
  }
  void operator()() { resume(); }
  void *address() const { return ptr; }
  void resume() const { __builtin_coro_resume(ptr); }
  void destroy() const { __builtin_coro_destroy(ptr); }
  bool done() const { return __builtin_coro_done(ptr); }
  coroutine_handle &operator=(decltype(nullptr)) {
    ptr = nullptr;
    return *this;
  }
  coroutine_handle(decltype(nullptr)) : ptr(nullptr) {}
  coroutine_handle() : ptr(nullptr) {}
  explicit operator bool() const { return ptr; }

protected:
  void *ptr;
};

template <typename Promise> struct coroutine_handle : coroutine_handle<> {
  using coroutine_handle<>::operator=;

  static coroutine_handle from_address(void *addr) noexcept {
    coroutine_handle me;
    me.ptr = addr;
    return me;
  }

  Promise &promise() const {
    return *reinterpret_cast<Promise *>(
        __builtin_coro_promise(ptr, alignof(Promise), false));
  }
  static coroutine_handle from_promise(Promise &promise) {
    coroutine_handle p;
    p.ptr = __builtin_coro_promise(&promise, alignof(Promise), true);
    return p;
  }
};

  template <typename _PromiseT>
  bool operator==(coroutine_handle<_PromiseT> const& _Left,
    coroutine_handle<_PromiseT> const& _Right) noexcept
  {
    return _Left.address() == _Right.address();
  }

  template <typename _PromiseT>
  bool operator!=(coroutine_handle<_PromiseT> const& _Left,
    coroutine_handle<_PromiseT> const& _Right) noexcept
  {
    return !(_Left == _Right);
  }

struct suspend_always {
  bool await_ready() { return false; }
  void await_suspend(coroutine_handle<>) {}
  void await_resume() {}
};
struct suspend_never {
  bool await_ready() { return true; }
  void await_suspend(coroutine_handle<>) {}
  void await_resume() {}
};

}}} // std::experimental::coroutines_v1

template <typename RAIterator>
struct left_loop_generator
{
    using underlying_iterator = RAIterator;

    using index_type =
        typename std::iterator_traits<underlying_iterator>::difference_type;

    using reference =
        typename std::iterator_traits<underlying_iterator>::reference;

    using pointer =
        typename std::iterator_traits<underlying_iterator>::pointer;

    struct position
    {
        underlying_iterator uit; 

        index_type i; // Inner loop index.
        index_type j; // Outer loop index.
    }; 

    struct promise_type
    {
        using return_type = left_loop_generator;

        position pos;

        std::experimental::suspend_always yield_value(position pos_)
        {
            pos = pos_;
            return {};
        }

        std::experimental::suspend_always initial_suspend() { return {}; }

        std::experimental::suspend_always final_suspend() { return {}; }

        left_loop_generator get_return_object()
        {
            return left_loop_generator{this};
        }

        void return_void() {}
    };

    struct iterator
    {
        std::experimental::coroutine_handle<promise_type> coro;
        bool done;

        iterator(std::experimental::coroutine_handle<promise_type> coro_, bool done_)
          : coro(coro_), done(done_)
        {}

        iterator& operator++()
        {
            coro.resume();
            done = coro.done();
            return *this;
        }

        constexpr bool operator==(iterator const& rhs) const noexcept
        {
            return done == rhs.done;
        }

        constexpr bool operator!=(iterator const& rhs) const noexcept
        {
            return !(*this == rhs);
        }

        std::tuple<index_type, index_type> index() const noexcept
        {
            return std::tuple<index_type, index_type>(coro.promise().pos.i,
                                                      coro.promise().pos.j);
        }

        position operator*() const
        {
            return coro.promise().pos;
        }

/*
        reference operator*() const
        {
            return *coro.promise().pos.uit;
        }

        pointer operator->() const
        {
            return &(operator*());
        }
*/
    };

    iterator begin()
    {
        p.resume();
        return {p, p.done()};
    }

    iterator end()
    {
        return {p, true};
    }

    left_loop_generator(left_loop_generator&& rhs)
      : p(rhs.p)
    {
        rhs.p = nullptr;
    }

    ~left_loop_generator() {
        if (p)
            p.destroy();
    }

  private:
    // Do we need this constructor?
    explicit left_loop_generator(promise_type* p)
      : p(std::experimental::coroutine_handle<promise_type>::from_promise(*p))
    {}

    std::experimental::coroutine_handle<promise_type> p;
};

template <typename RAIterator, typename DifferenceType>
left_loop_generator<RAIterator>
generate_left_loop(RAIterator uit, DifferenceType ni, DifferenceType nj) 
{
    using position = typename left_loop_generator<RAIterator>::position;

/*
    for (DifferenceType j = 0; j < nj; ++j)
        for (DifferenceType i = 0; i < ni; ++i)
            co_yield position{uit + (i + j * ni), i, j};
*/
/*
    for (DifferenceType j = 0; j != nj; ++j)
        for (DifferenceType i = 0; i != ni; ++i)
            co_yield position{uit++, i, j};
*/
/*
    __builtin_assume(nj > 0);
    __builtin_assume(ni > 0);
    for (DifferenceType i = 0, j = 0; j != nj; ++j, i = 0)
        for (; i != ni; ++i)
            co_yield position{uit++, i, j};
*/
/*
    __builtin_assume(nj > 0);
    __builtin_assume(ni > 0);
    for (DifferenceType i = 0, j = 0; j != nj; ++j, i = 0)
        for (; i != ni; ++i)
            co_yield position{uit++, i, j};
*/
    __builtin_assume(nj > 0);
    __builtin_assume(ni > 0);
    for (DifferenceType i = 0, j = 0; j != nj; ++j, i = 0)
        for (; i != ni; ++i)
            co_yield position{uit, i, j};
}

void transform_iterator(std::ptrdiff_t N, std::vector<double>& A)
{
    __builtin_assume((N % 32) == 0);

    #pragma clang loop vectorize(enable) interleave(enable)
//    for (double& a : generate_left_loop(A.data(), N, N))
//        a = 3.14F;
    for (auto a : generate_left_loop(A.data(), N, N))
        a.uit[a.i + a.j * N] = 3.14F;
}
#endif

#if defined(TRANSFORM_LOOP)
void transform_loop(std::ptrdiff_t N, double* __restrict__ A)
{
    __builtin_assume((N % 32) == 0);

    A = (double* __restrict__) __builtin_assume_aligned(A, 32);

    #pragma clang loop vectorize(enable) interleave(enable)
    for (std::ptrdiff_t j = 0; j < N; ++j)
        for (std::ptrdiff_t i = 0; i < N; ++i)
            A[i + j * N] = 3.14F;
}
#endif

#if defined(TEST)
int main()
{
    {
        // [a00 a01 a02]
        // [a10 a11 a12]

        std::vector<std::string> d = {"a00", "a10", "a01", "a11", "a02", "a12"};

        auto g = generate_left_loop(d.begin(), 2, 3);

        auto first = g.begin();
        auto last = g.end();

        #pragma clang loop vectorize(enable) interleave(enable)
        for (; first != last; ++first)
        {
            std::vector<std::string>::difference_type i, j;
            std::tie(i, j) = first.index();
            std::cout << "(" << i << " " << j << ") : " << *first << std::endl;
        }
    }
}
#endif


