module Src.Main exposing (..)

import Html

import Src.Models as Models
import Src.Updates as Updates
import Src.Views as Views

init : (Models.Model, Cmd Models.Msg)
init = (Models.initModel, Cmd.none)

subscriptions : Models.Model -> Sub Models.Msg
subscriptions model = Sub.none

main : Program Never Models.Model Models.Msg
main =
    Html.program
        { init = init
        , view = Views.view
        , update = Updates.update
        , subscriptions = subscriptions
        }
