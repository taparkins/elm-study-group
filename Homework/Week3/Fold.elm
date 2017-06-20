module Fold exposing (..)

fold : (a -> b -> b) -> b -> List a -> b
fold func start list = start

test : Bool
test = testFoldEmptyListEmptyStart
    && testFoldEmptyListNonEmptyStart
    && testFoldSingletonListEmptyStart
    && testFoldSingletonListNonEmptyStart
    && testFoldMultipleListEmptyStart
    && testFoldMultipleListNonEmptyStart

testFoldEmptyListEmptyStart : Bool
testFoldEmptyListEmptyStart = (fold String.append "" []) == ""

testFoldEmptyListNonEmptyStart : Bool
testFoldEmptyListNonEmptyStart = (fold String.append "Hello" []) == "Hello"

testFoldSingletonListEmptyStart : Bool
testFoldSingletonListEmptyStart = (fold String.append "" ["abc"]) == "abc"

testFoldSingletonListNonEmptyStart : Bool
testFoldSingletonListNonEmptyStart = (fold String.append "Hello" ["abc"]) == "Helloabc"

testFoldMultipleListEmptyStart : Bool
testFoldMultipleListEmptyStart = (fold String.append "" ["abc", "123", "world"]) == "abc123world"

testFoldMultipleListNonEmptyStart : Bool
testFoldMultipleListNonEmptyStart = (fold String.append "" ["abc", "123", "world"]) == "abc123world"
