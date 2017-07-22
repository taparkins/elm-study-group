module Homework.Week6.Main exposing (..)

import Html


-- Week 5 Homework: Edit a Sudoku Board
--
-- Last week you should have created a Sudoku Board that can be printed
-- to the screen. This week, extend that implementation by adding some
-- editability to the screen.
--
-- This file is still an empty shell, so you will want to copy over the
-- code from your Week4 implementation. Alternatively, you can start with
-- the code from the sample solution for Week4, though I'd urge you to
-- work with your own code if at all possible. ;)


type alias Model = {}

initModel : Model
initModel = {}


type Msg = NoOp


init : (Model, Cmd Msg)
init = (initModel, Cmd.none)


view : Model -> Html.Html Msg
view model = Html.div [] [ Html.text "Hello World" ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)


main : Program Never Model Msg
main = Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \model -> Sub.none
    }
