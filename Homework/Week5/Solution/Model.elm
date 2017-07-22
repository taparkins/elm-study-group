module Homework.Week5.Solution.Model exposing (..)

import Matrix


type alias Model =
    { matrix : Matrix.Matrix (Maybe Int)
    , errorMessage : Maybe String
    , validationMessage : Maybe String
    }

initModel : Model
initModel =
    { matrix = Matrix.square 9 (\_ -> Just 0)
    , errorMessage = Nothing
    , validationMessage = Nothing
    }


type Msg = UpdateCell Matrix.Location (Maybe Int)
         | UpdateCellError
         | SubmitBoard Bool

