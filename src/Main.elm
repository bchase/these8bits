module Main exposing (main)

import Html exposing (program)
import Html.Styled exposing (toUnstyled)
import Types exposing (Model, Msg)
import Home


main : Program Never Model Msg
main =
  program
    { update = Home.update
    , view = toUnstyled << Home.view
    , init = Home.init
    , subscriptions = Home.subscriptions
    }
