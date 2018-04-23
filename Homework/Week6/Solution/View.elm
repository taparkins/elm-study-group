module Homework.Week6.Solution.View exposing (..)

import Homework.Week6.Solution.Model as Model
import Homework.Week6.Solution.Logic as Logic

import Html
import Html.Attributes as Attributes
import Html.Events as Events
import Matrix
import ParseInt


view : Model.Model -> Html.Html Model.Msg
view model = Html.div
    [ Attributes.style [ ("width", "100%") ] ]
    [ sudokuTableView model.matrix
    , Html.br [] []
    , sudokuRestartButtonView
    , sudokuTestButtonView model.matrix
    , Html.br [] []
    , sudokuErrorView model.errorMessage
    , sudokuValidationView model.validationMessage
    ]


sudokuErrorView : Maybe String -> Html.Html Model.Msg
sudokuErrorView errorMsg =
    let content = case errorMsg of
        Nothing -> ""
        Just value -> value
    in
       Html.div
        [ Attributes.style
            [ ("width", "100%")
            , ("text-align", "center")
            , ("color", "red")
            ]
        ]
        [ Html.text content ]


sudokuValidationView : Maybe String -> Html.Html Model.Msg
sudokuValidationView errorMsg =
    let content = case errorMsg of
        Nothing -> ""
        Just value -> value
    in
       Html.div
        [ Attributes.style
            [ ("width", "100%")
            , ("text-align", "center")
            , ("color", "green")
            ]
        ]
        [ Html.text content ]


sudokuTestButtonView : Matrix.Matrix (Maybe Int) -> Html.Html Model.Msg
sudokuTestButtonView sudoku =
    let emitValid s = Model.SubmitBoard (Logic.validateBoard s)
    in
        Html.button
            [ Events.onClick (emitValid sudoku)
            , Attributes.style
                [ ("width", "5%")
                , ("margin", "auto")
                , ("display", "block")
                ]
            ]
            [ Html.text "Valid?" ]


sudokuRestartButtonView : Html.Html Model.Msg
sudokuRestartButtonView =
    Html.button
        [ Events.onClick Model.GetNewSudoku
        , Attributes.style
            [ ("width", "5%")
            , ("margin", "auto")
            , ("display", "block")
            ]
        ]
        [ Html.text "Restart" ]


sudokuTableView : Matrix.Matrix (Maybe Int) -> Html.Html Model.Msg
sudokuTableView matrix = Html.div
    [ Attributes.style
        [ ("width", "33%")
        , ("margin", "auto")
        ]
    ]
    [ Html.table
        [ Attributes.style
            [ ("border", "1px solid black")
            , ("border-collapse", "collapse")
            , ("width", "100%")
            , ("margin", "auto")
            , ("font-size", "20px")
            , ("text-align", "center")
            ]
        ]
        [ Html.tbody [] (tableContentFromMatrix matrix) ] ]

tableContentFromMatrix : Matrix.Matrix (Maybe Int) -> List (Html.Html Model.Msg)
tableContentFromMatrix matrix =
       Matrix.toList matrix
    |> List.indexedMap (,)
    |> List.map matrixRowToHtmlRow

matrixRowToHtmlRow : (Int, List (Maybe Int)) -> Html.Html Model.Msg
matrixRowToHtmlRow (x, row) =
       List.indexedMap (\y l -> (x,y,l)) row
    |> List.map cellToHtmlCell
    |> Html.tr [ Attributes.style [ ("border", "1px solid black") ] ]

cellToHtmlCell : (Int, Int, Maybe Int) -> Html.Html Model.Msg
cellToHtmlCell (x, y, cell) =
    let content =
        case cell of
            Nothing -> ""
            Just value -> toString value
        location = Matrix.loc x y
    in
       Html.td
            [ Attributes.style [ ("border", "1px solid black") ] ]
            [ Html.input
                [ Events.onInput (cellInputToMsg location)
                , Attributes.style [("width", "100%") ]
                , Attributes.attribute "maxlength" "1"
                , Attributes.attribute "value" content
                ]
                []
            ]

cellInputToMsg : Matrix.Location -> String -> Model.Msg
cellInputToMsg location value =
    case value of
        "" -> Model.UpdateCell location Nothing
        _ -> case ParseInt.parseInt value of
            Err _ -> Model.UpdateCellError
            Ok intValue -> Model.UpdateCell location (Just intValue)

