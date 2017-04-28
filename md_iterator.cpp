#include <vector>
#include <iterator>
#include <iostream>

#if defined(TRANSFORM_GENERATOR)
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

template <typename RAIterator>
struct left_loop_generator
{
    using difference_type =
        typename std::iterator_traits<RAIterator>::difference_type;

    using reference =
        typename std::iterator_traits<RAIterator>::reference;

    struct promise_type
    {
        
    };
};

template <typename Iterator>
using value_t = typename std::iterator_traits<Iterator>::value_type;

template <typename Iterator>
using diff_t = typename std::iterator_traits<Iterator>::difference_type;

// Pre-conditions: extent_i is greater than 0.
//                 stride_i is greater than 0.
template <typename RAIterator>
generator<std::tuple<value_t<RAIterator>, diff_t<RAIterator> > >
generate_left_loop(RAIterator uit, diff_t<RAIterator> extent_i,
                   diff_t<RAIterator> stride_i = 1, diff_t<RAIterator> i = 0)
{
  for (int i = 0; i < n; ++i)
    co_yield i;
}

struct left_loop_iterator
{

    // Pre-condition: extent_i_ is greater than than 0.
    left_loop_iterator(RAIterator uit_, difference_type extent_i_,
                       difference_type stride_i_ = 1, difference_type i_ = 0)
      : uit(uit_), extent_i(extent_i_), stride_i(stride_i_), i(i_)
    {}

    left_loop_iterator(left_loop_iterator const&) = default;
    left_loop_iterator(left_loop_iterator&&) = default;

    bool operator==(left_loop_iterator const& rhs) const
    {
        return extent_i == rhs.extent_i && stride_i == rhs.stride_i //&& i == rhs.i
            && uit == rhs.uit;
    }

    bool operator!=(left_loop_iterator const& rhs) const
    {
        return !(*this == rhs);
    }

    constexpr difference_type index() const
    {
        return i * stride_i;
    }

    reference operator*() const
    {
        return uit[i * stride_i];
    }

    left_loop_iterator& operator++()
    {
        if (extent_i - 1 == i)          // inner-loop condition
        {
            // Change rows.
            uit += extent_i * stride_i;
            i = 0;                      // inner-loop init statement
        }
        else
        {
            // Change columns.
            uit += stride_i;
            i = i + 1;                  // inner-loop increment expression
        }

        return *this;
    }

    left_loop_iterator operator++(int)
    {
        left_loop_iterator tmp(*this);
        ++(*this);
        return tmp; 
    } 

  private:
    RAIterator uit; // Underlying iterator.

    difference_type const extent_i; // Extent of i.
    difference_type const stride_i; // Stride of i.

    difference_type i;  // Current i coordinate.
};

void transform_iterator(std::size_t N, std::vector<double>& A)
{
    left_loop_iterator<std::vector<double>::iterator> Afirst(A.begin(), N);
    left_loop_iterator<std::vector<double>::iterator> Alast(A.end(), N, 1, N * N);

    __builtin_assume((N % 32) == 0);

    for (; Afirst != Alast; ++Afirst)
        *Afirst = 3.14F;
}
#endif

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

template <typename RAIterator>
struct left_loop_iterator
{
    using difference_type = typename std::iterator_traits<RAIterator>::difference_type;

    using reference = typename std::iterator_traits<RAIterator>::reference;

    // Pre-condition: extent_i_ is greater than than 0.
    left_loop_iterator(RAIterator uit_, difference_type extent_i_,
                       difference_type stride_i_ = 1, difference_type i_ = 0)
      : uit(uit_), extent_i(extent_i_), stride_i(stride_i_), i(i_)
    {}

    left_loop_iterator(left_loop_iterator const&) = default;
    left_loop_iterator(left_loop_iterator&&) = default;

    bool operator==(left_loop_iterator const& rhs) const
    {
        return extent_i == rhs.extent_i && stride_i == rhs.stride_i //&& i == rhs.i
            && uit == rhs.uit;
    }

    bool operator!=(left_loop_iterator const& rhs) const
    {
        return !(*this == rhs);
    }

    constexpr difference_type index() const
    {
        return i * stride_i;
    }

    reference operator*() const
    {
        return uit[i * stride_i];
    }

    left_loop_iterator& operator++()
    {
        if (extent_i - 1 == i)          // inner-loop condition
        {
            // Change columns.
            uit += extent_i * stride_i;
            i = 0;                      // inner-loop init statement
        }
        else
        {
            // Change rows.
            uit += stride_i;
            i = i + 1;                  // inner-loop increment expression
        }

        return *this;
    }

    left_loop_iterator operator++(int)
    {
        left_loop_iterator tmp(*this);
        ++(*this);
        return tmp; 
    } 

  private:
    RAIterator uit; // Underlying iterator.

    difference_type const extent_i; // Extent of i.
    difference_type const stride_i; // Stride of i.

    difference_type i;  // Current i coordinate.
};

void transform_iterator(std::size_t N, std::vector<double>& A)
{
    left_loop_iterator<std::vector<double>::iterator> Afirst(A.begin(), N);
    left_loop_iterator<std::vector<double>::iterator> Alast(A.end(), N, 1, N * N);

    __builtin_assume((N % 32) == 0);

    for (; Afirst != Alast; ++Afirst)
        *Afirst = 3.14F;
}
#endif

#if defined(TRANSFORM_LOOP)
void transform_loop(std::size_t N, double* __restrict__ A)
{
    __builtin_assume((N % 32) == 0);

    A = (double* __restrict__) __builtin_assume_aligned(A, 32);

    for (std::size_t j = 0; j < N; ++j)
        for (std::size_t i = 0; i < N; ++i)
            A[i + j * N] = 3.14F;
}
#endif

#if defined(TEST)
int main()
{
    {
        // [0 1]
        // [2 3]
        //
        // 0:0, 1:1, 2:2, 3:3

        std::vector<double> d = {0, 1, 2, 3};

        left_loop_iterator<std::vector<double>::iterator> first(d.begin(), 2);
        left_loop_iterator<std::vector<double>::iterator> last(d.end(), 2, 1, d.size());

/*
        std::cout << "0:" << (first != last) << std::endl;
        ++first;
        std::cout << "1:" << (first != last) << std::endl;
        ++first;
        std::cout << "2:" << (first != last) << std::endl;
        ++first;
        std::cout << "3:" << (first != last) << std::endl;
*/

        for (; first != last; ++first)
        {
            std::cout << first.index() << ":" << *first << std::endl;
        }
    }
}
#endif

