module Types exposing (Model, Msg(..), Url)

import Time exposing (Time)


type alias Model =
  { rows : List Int
  }


type Msg
  = NoOp
  | Tick Time


type alias Url =
  String
