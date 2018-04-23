module Homework.Week6.Solution.Command exposing (..)

import Homework.Week6.Solution.Model as Model

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline as DecodePipeline
import RemoteData


getSudokuUrl : String
getSudokuUrl = "http://localhost:4000/sudoku/"


getSudokuCmd : Cmd Model.Msg
getSudokuCmd =
       Http.get getSudokuUrl sudokuDecoder
    |> RemoteData.sendRequest
    |> Cmd.map handleSudokuResponse


sudokuDecoder : Decode.Decoder (List Model.LocationValues)
sudokuDecoder = Decode.list locationValueDecoder

locationValueDecoder : Decode.Decoder Model.LocationValues
locationValueDecoder =
       DecodePipeline.decode Model.LocationValues
    |> DecodePipeline.required "x" Decode.int
    |> DecodePipeline.required "y" Decode.int
    |> DecodePipeline.required "value" Decode.int


handleSudokuResponse : RemoteData.WebData (List Model.LocationValues) -> Model.Msg
handleSudokuResponse webData =
    case webData of
        RemoteData.NotAsked -> Model.NoOp
        RemoteData.Loading -> Model.NoOp
        RemoteData.Failure e -> Model.OnGetSudokuError (messageForError e)
        RemoteData.Success payload -> Model.OnGetSudokuResponse payload

messageForError : Http.Error -> String
messageForError e =
    case e of
        Http.Timeout -> "Request for Sudoku timed out!"
        Http.NetworkError -> "Unknown network error happened while requesting for Sudoku!"
        Http.BadUrl _ -> "WTF, your URL for requesting Sudoku was wrong!"
        Http.BadStatus _ -> "The server replied with a bad status while requesting for Sudoku!"
        Http.BadPayload _ _ -> "The server sent an unexpected payload while requesting for Sudoku!"

