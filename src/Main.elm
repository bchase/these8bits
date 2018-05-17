module Main exposing (main)

import Html exposing (program)
import Html.Styled exposing (toUnstyled)
import Navigation
import Types exposing (Model, Msg(SetLocation))
import Routes
import Home


main : Program Never Model Msg
main =
  Navigation.program SetLocation
    { update = Home.update
    , view = toUnstyled << Home.view
    , init = Home.init
    , subscriptions = Home.subscriptions
    }
