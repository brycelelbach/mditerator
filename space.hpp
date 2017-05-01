///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015-7 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///////////////////////////////////////////////////////////////////////////////

#if !defined(BOOST_B107541B_3A73_495D_B9BB_F627001CF0F9)
#define BOOST_B107541B_3A73_495D_B9BB_F627001CF0F9

struct position_2d
{
    using index_type = decltype("me" - "ow"); // Signed 4 life.

    index_type i; // Inner loop index.
    index_type j; // Outer loop index.
}; 

struct dimension_2d
{
    using index_type = position_2d::index_type; 

    index_type const extent;
    index_type       idx;
}; 

#endif // BOOST_B107541B_3A73_495D_B9BB_F627001CF0F9

