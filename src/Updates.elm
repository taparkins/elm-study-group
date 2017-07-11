module Src.Updates exposing (..)

import Src.Models as Models

update : Models.Msg -> Models.Model -> (Models.Model, Cmd Models.Msg)
update msg model =
    case msg of
        Models.NoOp -> (model, Cmd.none)

