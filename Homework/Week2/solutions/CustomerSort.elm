module Homework.Week2.Solutions.CustomerSort exposing (..)

import Customer exposing (Customer)

sort : (a -> a -> Bool) -> List a -> List a
sort cmp list =
    case list of
        [] -> list
        pivot::rest ->
            let (bigger, smaller) = List.partition (cmp pivot) rest
            in List.concat [ sort cmp smaller
                           , [pivot]
                           , sort cmp bigger
                           ]


sortByCheckoutTotal : List Customer -> List Customer
sortByCheckoutTotal list =
    sort (\a b -> a.checkoutTotal < b.checkoutTotal) list

sortByLastThenFirst : List Customer -> List Customer
sortByLastThenFirst list =
    sort
        (\a b -> a.lastName < b.lastName ||
                    (a.lastName == b.lastName &&
                     a.firstName < b.firstName))
        list

test : Bool
test = testEmpty
    && testSingleton
    && testSorted
    && testReverseSorted
    && testScrambled

testEmpty : Bool
testEmpty = testEmptyByCheckoutTotal
         && testEmptyByLastThenFirst

testSingleton : Bool
testSingleton = testSingletonByCheckoutTotal
             && testSingletonByLastThenFirst

testSorted : Bool
testSorted = testSortedByCheckoutTotal
          && testSortedByLastThenFirst

testReverseSorted : Bool
testReverseSorted = testReverseSortedByCheckoutTotal
                 && testReverseSortedByLastThenFirst

testScrambled : Bool
testScrambled = testScrambledByCheckoutTotal
             && testScrambledByLastThenFirst

testEmptyByCheckoutTotal : Bool
testEmptyByCheckoutTotal = sortByCheckoutTotal [] == []

testEmptyByLastThenFirst : Bool
testEmptyByLastThenFirst = sortByLastThenFirst [] == []

testSingletonByCheckoutTotal : Bool
testSingletonByCheckoutTotal = sortByCheckoutTotal [{firstName = "Bob", lastName = "Saget", checkoutTotal = 5}] ==
                                                   [{firstName = "Bob", lastName = "Saget", checkoutTotal = 5}]

testSingletonByLastThenFirst : Bool
testSingletonByLastThenFirst = sortByLastThenFirst [{firstName = "Bob", lastName = "Saget", checkoutTotal = 5}] ==
                                                   [{firstName = "Bob", lastName = "Saget", checkoutTotal = 5}]

testSortedByCheckoutTotal : Bool
testSortedByCheckoutTotal = sortByCheckoutTotal [ {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                ] ==
                                                [ {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                ]

testSortedByLastThenFirst : Bool
testSortedByLastThenFirst = sortByLastThenFirst [ {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                ] ==
                                                [ {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                ]

testReverseSortedByCheckoutTotal : Bool
testReverseSortedByCheckoutTotal = sortByCheckoutTotal [ {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                       , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                       , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                       , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                       , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                       ] ==
                                                       [ {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                       , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                       , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                       , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                       , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                       ]

testReverseSortedByLastThenFirst : Bool
testReverseSortedByLastThenFirst = sortByLastThenFirst [ {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                       , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                       , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                       , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                       , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                       ] ==
                                                       [ {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                       , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                       , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                       , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                       , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                       ]

testScrambledByCheckoutTotal : Bool
testScrambledByCheckoutTotal = sortByCheckoutTotal [ {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                   , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                   , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                   , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                   , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                   ] ==
                                                   [ {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                   , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                   , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                   , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                   , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                   ]

testScrambledByLastThenFirst : Bool
testScrambledByLastThenFirst = sortByLastThenFirst [ {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                   , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                   , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                   , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                   , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                   ] ==
                                                   [ {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                   , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                   , {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                   , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                   , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                   ]

