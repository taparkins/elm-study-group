module Homework.Week6.Solution.Update exposing (..)

import Homework.Week6.Solution.Command as Command
import Homework.Week6.Solution.Model as Model

import Dict
import Matrix


update : Model.Msg -> Model.Model -> (Model.Model, Cmd Model.Msg)
update msg model =
    case msg of
        Model.NoOp -> (model, Cmd.none)
        Model.UpdateCell loc newValue -> ({ model | errorMessage = Nothing
                                                  , matrix = Matrix.set loc newValue model.matrix }
                                          , Cmd.none)
        Model.UpdateCellError -> ({ model | errorMessage = Just "Invalid value for cell" }, Cmd.none)
        Model.SubmitBoard isValid ->
            if isValid
            then ({ model | errorMessage = Nothing, validationMessage = Just "Solved! Good Job!" }, Cmd.none)
            else ({ model | errorMessage = Nothing, validationMessage = Just "Sorry, your Sudoku isn't valid" }, Cmd.none)
        Model.OnGetSudokuError errMsg -> ({ model | errorMessage = Just errMsg }, Cmd.none)
        Model.OnGetSudokuResponse values ->
            let insertValue value dict =
                    Dict.insert
                        (Matrix.loc value.x value.y)
                        value.value
                        dict
                newMatrix =
                       List.foldl insertValue Dict.empty values
                    |> (flip Dict.get)
                    |> Matrix.matrix 9 9
            in
               ({ model | matrix = newMatrix
                        , errorMessage = Nothing }
               , Cmd.none)
        Model.GetNewSudoku -> (model, Command.getSudokuCmd)
