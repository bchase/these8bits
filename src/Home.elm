module Home exposing (init, subscriptions, update, view)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Types exposing (Model, Msg(..), Url)


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
  div [ id "main", css [ fontFamilies [ "Ubuntu Mono" ], fontFamily monospace, textAlign center ] ]
    [ stylesheet "https://fonts.googleapis.com/css?family=Ubuntu+Mono:400,700"
    , div [ id "masthead" ]
      [ h1 [] [ text "these8bits" ]
      , p [] [ a [ href "https://github.com/bchase" ] [ text "GitHub" ] ]
      , p [] [ a [ href "mailto:brad@these8bits.com" ] [ text "Contact" ] ]
      ]
    ]



--- view helpers ---


stylesheet : Url -> Html Msg
stylesheet url =
  node "link" [ href url, rel "stylesheet" ] []
