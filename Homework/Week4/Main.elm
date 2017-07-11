module Homework.Week4.Main exposing (..)

import Html

type alias Model = {}

initModel : Model
initModel = {}

type Msg = NoOp


init : (Model, Cmd Msg)
init = (initModel, Cmd.none)


view : Model -> Html.Html Msg
view model = Html.div [] [ Html.text "Hello World" ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp -> (model, Cmd.none)


main : Program Never Model Msg
main = Html.program
    { init = init
    , view = view
    , update = update
    -- Feel free to disregard subscriptions for now; we'll come back to those another week
    , subscriptions = \model -> Sub.none
    }
