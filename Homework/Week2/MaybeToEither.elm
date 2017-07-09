module Homework.Week2.MaybeToEither exposing (..)

import Customer

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
