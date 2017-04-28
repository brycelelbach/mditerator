#include "generator.hpp"

void print(int i);

#if defined(CHECK)
#include <iostream>

void print(int i)
{
    std::cout << i << std::endl;
}
#endif

generator<int> fib(int n) {
  for (int i = 0; i < n; ++i)
    co_yield i;
}

int main() {
  for (auto v : fib(5))
    print(v);
}

