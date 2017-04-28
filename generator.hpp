#pragma once

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

}}}

namespace coro = std::experimental::coroutines_v1;

template <typename _Ty> struct generator {
  struct promise_type {
    _Ty current_value;
    coro::suspend_always yield_value(_Ty value) {
      this->current_value = value;
      return {};
    }
    coro::suspend_always initial_suspend() { return {}; }
    coro::suspend_always final_suspend() { return {}; }
    generator get_return_object() { return generator{this}; };
    void return_void() {}
  };

  struct iterator {
    coro::coroutine_handle<promise_type> _Coro;
    bool _Done;

    iterator(coro::coroutine_handle<promise_type> Coro, bool Done)
        : _Coro(Coro), _Done(Done) {}

    iterator &operator++() {
      _Coro.resume();
      _Done = _Coro.done();
      return *this;
    }

    bool operator==(iterator const &_Right) const {
      return _Done == _Right._Done;
    }

    bool operator!=(iterator const &_Right) const { return !(*this == _Right); }

    _Ty const &operator*() const { return _Coro.promise().current_value; }

    _Ty const *operator->() const { return &(operator*()); }
  };

  iterator begin() {
    p.resume();
    return {p, p.done()};
  }

  iterator end() { return {p, true}; }

  generator(generator &&rhs) : p(rhs.p) { rhs.p = nullptr; }

  ~generator() {
    if (p)
      p.destroy();
  }

private:
  explicit generator(promise_type *p)
      : p(coro::coroutine_handle<promise_type>::from_promise(*p)) {}

  coro::coroutine_handle<promise_type> p;
};

