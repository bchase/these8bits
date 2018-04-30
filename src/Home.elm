module Home exposing (init, subscriptions, update, view)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Types exposing (Model, Msg(..))


--- init / subscriptions ---


init : ( Model, Cmd Msg )
init =
  () ! []


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none



--- update ---


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      model ! []



--- view ---


view : Model -> Html Msg
view _ =
  div [ id "main", css [ textAlign center ] ]
    [ div [ id "masthead" ]
      [ h1 [] [ text "these8bits" ]
      ]
    ]
