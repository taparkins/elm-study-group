module Homework.Week2.Solutions.Test exposing (..)

type Either a b = Value a
                | Error b

type alias IntError = Either Int

foo : Int -> IntError String
foo x =
    if x > 0
    then Value x
    else Error "LESS THAN ZERO D:"
