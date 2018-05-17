module Types exposing (Model, Msg(..), Page(..), Url, Path)

import Navigation
import Time exposing (Time)


type alias Model =
  { page : Page
  , cursor : Bool
  , rows : List Int
  }


type Msg
  = NoOp
  | FlashCursor Time
  | RollAnimation Time
  | ChangePage Page
  | SetLocation Navigation.Location


type Page
  = Homepage
  | Portfolio
  | PageNotFound


type alias Url =
  String


type alias Path =
  String
