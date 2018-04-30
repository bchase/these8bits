module Main exposing (..)

import Html exposing (..)


main : Program Never Model Msg
main =
  program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }



--- Model / init / subscriptions ---


type alias Model =
  ()


init : ( Model, Cmd Msg )
init =
  () ! []


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none



--- Msg / update ---


type Msg
  = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      model ! []



--- view ---


view : Model -> Html Msg
view _ =
  div [ class "elm" ]
    [ h1 [] [ text "these8bits" ]
    ]
