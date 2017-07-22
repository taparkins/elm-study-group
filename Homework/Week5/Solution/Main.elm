module Homework.Week5.Solution.Main exposing (..)

import Homework.Week5.Solution.Model as Model
import Homework.Week5.Solution.Update as Update
import Homework.Week5.Solution.View as View

import Html


init : (Model.Model, Cmd Model.Msg)
init = (Model.initModel, Cmd.none)


main : Program Never Model.Model Model.Msg
main = Html.program
    { init = init
    , view = View.view
    , update = Update.update
    -- Feel free to disregard subscriptions altogether; it's an advanced topic that isn't super important
    , subscriptions = \model -> Sub.none
    }
