module Homework.Week5.Solution.Logic exposing (..)

import Matrix
import Set

transpose : Matrix.Matrix a -> Matrix.Matrix a
transpose m =
       Matrix.toList m
    |> transpose_
    |> Matrix.fromList

transpose_ : List (List a) -> List (List a)
transpose_ m =
    let singleton x = [x]
    in
        case m of
            []          -> []
            [[]]        -> [[]]
            topRow::[]   -> List.map singleton topRow
            topRow::rows ->
                let transposeHead = transpose_ [topRow]
                    transposeRest = transpose_ rows
                in
                   List.map2 (++) transposeHead transposeRest


and : List Bool -> Bool
and = List.foldr (&&) True


validateBoard : Matrix.Matrix (Maybe Int) -> Bool
validateBoard board =
    let allValidCells =
           Matrix.flatten board
        |> List.map (Maybe.map (\x -> (x > 0) && (x < 10)))
        |> List.map (Maybe.withDefault False)
        |> and

        validSize =
           Matrix.rowCount board == 9
        && Matrix.colCount board == 9
    in
           allValidCells
        && validSize
        && (   Matrix.map (Maybe.withDefault 0) board
            |> validateSudoku)


validateSudoku : Matrix.Matrix Int -> Bool
validateSudoku sudoku =
       validateRows sudoku
    && validateColumns sudoku
    && validateGrids sudoku


validateRows : Matrix.Matrix Int -> Bool
validateRows sudoku =
       Matrix.toList sudoku
    |> List.map uniqueList
    |> and


validateColumns : Matrix.Matrix Int -> Bool
validateColumns sudoku =
       transpose sudoku
    |> validateRows


validateGrids : Matrix.Matrix Int -> Bool
validateGrids sudoku =
    let tupleToLocation tuple =
        let (x,y) = tuple
        in Matrix.loc x y

        verifySubgrid subgrid =
               List.map tupleToLocation subgrid
            |> List.filterMap (\loc -> Matrix.get loc sudoku)
            |> (\xs -> (List.length xs == 9) && uniqueList xs)
    in
       enumerateSubgrids
    |> List.map verifySubgrid
    |> and


enumerateSubgrids : List (List (Int, Int))
enumerateSubgrids =
    let indexGroups = [ [0,1,2]
                      , [3,4,5]
                      , [6,7,8]
                      ]

        product xs ys =
            List.concatMap
                (\x -> List.map (\y -> (x,y)) ys)
                xs
    in
           product indexGroups indexGroups
        |> List.map (\tup -> let (xs, ys) = tup in product xs ys)



uniqueList : List comparable -> Bool
uniqueList l =
    let s = Set.fromList l
    in
       (Set.size s) == (List.length l)

