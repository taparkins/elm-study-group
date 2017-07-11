module Homework.Week4.Main exposing (..)

import Html

type alias Model = {}

initModel : Model
initModel = {}

init : (Model, Cmd msg)
init = (initModel, Cmd.none)


view : Model -> Html.Html msg
view model = Html.div [] [ Html.text "Hello World" ]


main : Program Never Model msg
main = Html.program
    { init = init
    , view = view
    -- Feel free to disregard update for now; we'll come back to that next week
    , update = \msg model -> (model, Cmd.none)
    -- Feel free to disregard subscriptions altogether; it's an advanced topic that isn't super important
    , subscriptions = \model -> Sub.none
    }
