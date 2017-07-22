module Homework.Week5.Solution.Update exposing (..)

import Homework.Week5.Solution.Model as Model

import Matrix


update : Model.Msg -> Model.Model -> (Model.Model, Cmd Model.Msg)
update msg model =
    case msg of
        Model.UpdateCell loc newValue -> ({ model | errorMessage = Nothing
                                                  , matrix = Matrix.set loc newValue model.matrix }
                                          , Cmd.none)
        Model.UpdateCellError -> ({ model | errorMessage = Just "Invalid value for cell" }, Cmd.none)
        Model.SubmitBoard isValid ->
            if isValid
            then ({ model | errorMessage = Nothing, validationMessage = Just "Solved! Good Job!" }, Cmd.none)
            else ({ model | errorMessage = Nothing, validationMessage = Just "Sorry, your Sudoku isn't valid" }, Cmd.none)

