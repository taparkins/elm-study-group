module Homework.Week2.Solutions.MaybeToEither exposing (..)

import Customer exposing (Customer)

-- Below is the find function. It returns the first value of a list
-- that returns true for a provided check function.
--
-- Notice that it will return a Maybe, because it's possible no values
-- in the list will match the predicate.

find : (a -> Bool) -> List a -> Maybe a
find check list =
    case list of
        [] -> Nothing
        x::rest ->
            if check x
            then Just x
            else find check rest

-- The goal of this exercise is to write a function that finds the
-- first customer in a list that has a given name, and also a given
-- checkoutTotal. If no customer exists that does not match both
-- conditions, we want to let the user know why that is -- was the
-- given name absent in the list, or was the checkoutTotal, or both?
--
-- To accomplish this, you should create the Either type, and return
-- a meaningful String message in case no matches are found.
--
-- Unfortunately, no pre-built tests this time. Part of the exercise
-- is defining the types you'll need to complete the task. So bonus
-- homework: create some tests!

type Either a b = Value a
                | Error b

requireAll : List (a -> Bool) -> (a -> Bool)
requireAll predicates =
    case predicates of
        []      -> (\x -> True)
        [p]     -> p
        p::rest -> (\x -> p x && (requireAll rest) x)

formattedName : Customer -> String
formattedName customer = String.concat [customer.firstName, " ", customer.lastName]

searchCandidate : String -> Int -> List Customer -> Either Customer String
searchCandidate name total customers =
    let namePredicate   = (\customer -> name  == (formattedName customer))
        totalPredicate  = (\customer -> total == customer.checkoutTotal)
        predicates      = [namePredicate, totalPredicate]
        nameFindResult  = find namePredicate customers
        totalFindResult = find totalPredicate customers
        fullFindResult  = find (requireAll predicates) customers
    in
       case fullFindResult of
           Just customer -> Value customer
           Nothing ->
               case nameFindResult of
                   Just x ->
                       case totalFindResult of
                           Just y ->
                               Error "There were matching customers by name and total, but none with the same value."
                           Nothing ->
                               Error "There was a matching customer by name, but none by total."
                   Nothing ->
                       case totalFindResult of
                           Just y ->
                               Error "There was a matching customer by total, but none by name."
                           Nothing ->
                               Error "There were no matching customers for either name or total."

test : Bool
test = testEmpty
    && testMatchSingleton
    && testWrongTotalSingleton
    && testWrongNameSingleton
    && testWrongBothSingleton
    && testMatchMultiple
    && testWrongTotalMultiple
    && testWrongNameMultiple
    && testWrongBothMultiple
    && testMatchingDifferentRecords

testEmpty : Bool
testEmpty = searchCandidate "Bob Saget" 5 [] == Error "There were no matching customers for either name or total."

testMatchSingleton : Bool
testMatchSingleton = searchCandidate "Bob Saget" 5 [{firstName = "Bob", lastName = "Saget", checkoutTotal = 5}]
                      ==
                     Value {firstName = "Bob", lastName = "Saget", checkoutTotal = 5}

testWrongTotalSingleton : Bool
testWrongTotalSingleton = searchCandidate "Bob Saget" 0 [{firstName = "Bob", lastName = "Saget", checkoutTotal = 5}]
                          ==
                         Error "There was a matching customer by name, but none by total."

testWrongNameSingleton : Bool
testWrongNameSingleton = searchCandidate "Bog Dagget" 5 [{firstName = "Bob", lastName = "Saget", checkoutTotal = 5}]
                          ==
                         Error "There was a matching customer by total, but none by name."

testWrongBothSingleton : Bool
testWrongBothSingleton = searchCandidate "Bog Dagget" 0 [{firstName = "Bob", lastName = "Saget", checkoutTotal = 5}]
                          ==
                         Error "There were no matching customers for either name or total."

testMatchMultiple : Bool
testMatchMultiple = searchCandidate "Bob Saget" 5 [ {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                  , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                  , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                  , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                  , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                  ]
                          ==
                         Value {firstName = "Bob", lastName = "Saget", checkoutTotal = 5}

testWrongTotalMultiple : Bool
testWrongTotalMultiple = searchCandidate "Bob Saget" 0 [ {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                       , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                       , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                       , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                       , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                       ]
                          ==
                         Error "There was a matching customer by name, but none by total."

testWrongNameMultiple : Bool
testWrongNameMultiple = searchCandidate "Bog Dagget" 5 [ {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                       , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                       , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                       , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                       , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                       ]
                          ==
                         Error "There was a matching customer by total, but none by name."

testWrongBothMultiple : Bool
testWrongBothMultiple = searchCandidate "Bog Dagget" 0 [ {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                       , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                       , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                       , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                       , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                       ]
                          ==
                         Error "There were no matching customers for either name or total."

testMatchingDifferentRecords : Bool
testMatchingDifferentRecords = searchCandidate "Ashley Olsen" 4 [ {firstName = "Ashley",    lastName = "Olsen",   checkoutTotal = 3}
                                                                , {firstName = "Bob",       lastName = "Saget",   checkoutTotal = 5}
                                                                , {firstName = "Kelsey",    lastName = "Grammer", checkoutTotal = 4}
                                                                , {firstName = "Jenefer",   lastName = "Aniston", checkoutTotal = 2}
                                                                , {firstName = "Mary-Kate", lastName = "Olsen",   checkoutTotal = 1}
                                                                ]
                          ==
                         Error "There were matching customers by name and total, but none with the same value."
