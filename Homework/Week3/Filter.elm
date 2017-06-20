module Filter exposing (..)

import Arithmetic

filter : (a -> Bool) -> List a -> List a
filter predicate list = list

test : Bool
test = testEmptyList
    && testTrueFilter
    && testFalseFilter
    && testComplexFilter

testEmptyList : Bool
testEmptyList = (filter (\x -> True) []) == []

testTrueFilter : Bool
testTrueFilter = (filter (\x -> True) [1,2,3]) == [1,2,3]

testFalseFilter : Bool
testFalseFilter = (filter (\x -> False) [1,2,3]) == []

testComplexFilter : Bool
testComplexFilter = (filter Arithmetic.isEven [1,2,3,4,5]) == [2,4]

