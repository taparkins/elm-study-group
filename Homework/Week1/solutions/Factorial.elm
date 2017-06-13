module Factorial exposing (..)

factorial : Int -> Int
factorial n =
    if n < 2
    then 1
    else n * (factorial (n-1))

test : Bool
test = test0
    && test1
    && test2
    && test3
    && test4
    && test5
    && test10

test0 : Bool
test0 = factorial 0 == 1

test1 : Bool
test1 = factorial 1 == 1

test2 : Bool
test2 = factorial 2 == 2

test3 : Bool
test3 = factorial 3 == 6

test4 : Bool
test4 = factorial 4 == 24

test5 : Bool
test5 = factorial 5 == 120

test10 : Bool
test10 = factorial 10 == 3628800

