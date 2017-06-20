module FlatMap exposing (..)

import Arithmetic

flatMap : (a -> List b) -> List a -> List b
flatMap transform list = []

test : Bool
test = testEmptyList
    && testEmptyTransform
    && testSingletonListNonEmptyTransform
    && testMultipleListNonEmptyTransform
    && testMixedTransform

emptyTransform : Int -> List Int
emptyTransform x = []

nonEmptyTransform : Int -> List Int
nonEmptyTransform x = [x+1, x+2, x+3]

mixedTransform : Int -> List Int
mixedTransform x =
    if Arithmetic.isEven x
    then emptyTransform x
    else nonEmptyTransform x

testEmptyList : Bool
testEmptyList = (flatMap nonEmptyTransform []) == []

testEmptyTransform : Bool
testEmptyTransform = (flatMap emptyTransform [1,2,3]) == []

testSingletonListNonEmptyTransform : Bool
testSingletonListNonEmptyTransform = (flatMap nonEmptyTransform [1]) == [2,3,4]

testMultipleListNonEmptyTransform : Bool
testMultipleListNonEmptyTransform = (flatMap nonEmptyTransform [1,2,3]) == [2,3,4,3,4,5,4,5,6]

testMixedTransform : Bool
testMixedTransform = (flatMap mixedTransform [1,2,3,4]) == [2,3,4,4,5,6]
