module Homework.Week1.Sort exposing (..)

sort : List Int -> List Int
sort list = list

test = testEmptyList
    && testSingletonList
    && testReverseSortedList
    && testSortedList
    && testScrambledList

testEmptyList : Bool
testEmptyList = sort [] == []

testSingletonList : Bool
testSingletonList = sort [1] == [1]

testReverseSortedList : Bool
testReverseSortedList = sort [5,4,3,2,1] == [1,2,3,4,5]

testSortedList : Bool
testSortedList = sort [1,2,3,4,5] == [1,2,3,4,5]

testScrambledList : Bool
testScrambledList = sort [4,2,3,1,5] == [1,2,3,4,5]
