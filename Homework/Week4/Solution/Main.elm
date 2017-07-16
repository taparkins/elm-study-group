module Homework.Week4.Solution.Main exposing (..)

import Html
import Html.Attributes as Attributes
import Matrix

type alias Model =
    { matrix : Matrix.Matrix (Maybe Int)
    }

initModel : Model
initModel =
    { matrix = Matrix.square 9 (\_ -> Just 0)
    }

init : (Model, Cmd msg)
init = (initModel, Cmd.none)


view : Model -> Html.Html msg
view model = Html.div
    [ Attributes.style [ ("width", "100%") ] ]
    [ sudokuTableView model.matrix
    ]


sudokuTableView : Matrix.Matrix (Maybe Int) -> Html.Html msg
sudokuTableView matrix = Html.div
    [ Attributes.style
        [ ("width", "50%")
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

tableContentFromMatrix : Matrix.Matrix (Maybe Int) -> List (Html.Html msg)
tableContentFromMatrix matrix =
       Matrix.toList matrix
    |> List.map matrixRowToHtmlRow

matrixRowToHtmlRow : List (Maybe Int) -> Html.Html msg
matrixRowToHtmlRow row =
       List.map cellToHtmlCell row
    |> Html.tr [ Attributes.style [ ("border", "1px solid black") ] ]

cellToHtmlCell : Maybe Int -> Html.Html msg
cellToHtmlCell cell =
    let content =
        case cell of
            Nothing -> []
            Just x -> [ Html.text (toString x) ]
    in
       Html.td [ Attributes.style [ ("border", "1px solid black") ] ] content

main : Program Never Model msg
main = Html.program
    { init = init
    , view = view
    -- Feel free to disregard update for now; we'll come back to that next week
    , update = \msg model -> (model, Cmd.none)
    -- Feel free to disregard subscriptions altogether; it's an advanced topic that isn't super important
    , subscriptions = \model -> Sub.none
    }
