///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015-7 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

#if !defined(BOOST_5065A018_6A67_4A60_A22A_3B7C7FA37820)
#define BOOST_5065A018_6A67_4A60_A22A_3B7C7FA37820

#include <iterator>

namespace std { inline namespace __1
{

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

#endif // BOOST_5065A018_6A67_4A60_A22A_3B7C7FA37820

