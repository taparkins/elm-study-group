module Fibonacci exposing (..)

fibonacci : Int -> Int
fibonacci n =
    if n < 3
    then 1
    else (fibonacci (n-1)) + (fibonacci (n-2))

test : Bool
test = test1
    && test2
    && test3
    && test4
    && test5
    && test6
    && test7
    && test8
    && test9
    && test10

test1 : Bool
test1 = fibonacci 1 == 1

test2 : Bool
test2 = fibonacci 2 == 1

test3 : Bool
test3 = fibonacci 3 == 2

test4 : Bool
test4 = fibonacci 4 == 3

test5 : Bool
test5 = fibonacci 5 == 5

test6 : Bool
test6 = fibonacci 6 == 8

test7 : Bool
test7 = fibonacci 7 == 13

test8 : Bool
test8 = fibonacci 8 == 21

test9 : Bool
test9 = fibonacci 9 == 34

test10 : Bool
test10 = fibonacci 10 == 55

