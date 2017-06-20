module Map exposing (..)

map : (a -> b) -> List a -> List b
map func list = []

test : Bool
test = testMapEmptyList
    && testMapSingletonList
    && testMapMultipleList

addOne : Int -> Int
addOne x = x + 1

testMapEmptyList : Bool
testMapEmptyList = (map addOne []) == []

testMapSingletonList : Bool
testMapSingletonList = (map addOne [1]) == [2]

testMapMultipleList : Bool
testMapMultipleList = (map addOne [1, 2, 3]) == [2, 3, 4]

