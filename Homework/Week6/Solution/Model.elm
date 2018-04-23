module Homework.Week6.Solution.Model exposing (..)

import Matrix
import RemoteData


type alias Model =
    { matrix : Matrix.Matrix (Maybe Int)
    , errorMessage : Maybe String
    , validationMessage : Maybe String
    }


initModel : Model
initModel =
    { matrix = Matrix.square 9 (\_ -> Nothing)
    , errorMessage = Nothing
    , validationMessage = Nothing
    }


type Msg = UpdateCell Matrix.Location (Maybe Int)
         | UpdateCellError
         | SubmitBoard Bool
         | OnGetSudokuResponse (List LocationValues)
         | OnGetSudokuError String
         | GetNewSudoku
         | NoOp


type alias LocationValues =
    { x : Int
    , y : Int
    , value : Int
    }

