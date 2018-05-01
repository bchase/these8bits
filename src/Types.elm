module Types exposing (Model, Msg(..), Url)

import Time exposing (Time)


type alias Model =
  { cursor : Bool
  , rows : List Int
  }


type Msg
  = NoOp
  | FlashCursor Time
  | RollAnimation Time


type alias Url =
  String
