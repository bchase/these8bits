module Home exposing (init, subscriptions, update, view)

import Css exposing (..)
import Html.Styled as Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Maybe.Extra as Maybe
import Array
import Time exposing (every, millisecond)
import Types exposing (Model, Msg(..), Url)


--- init / subscriptions ---


init : ( Model, Cmd Msg )
init =
  let
    empty =
      Model <| List.reverse [ 0, 1, 2, 3, 4, 5, 6, 7 ]
  in
    empty ! []


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.batch
    [ every (450 * millisecond) Tick
    ]



--- update ---


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ rows } as model) =
  let
    roll : List Int -> List Int
    roll rs =
      rs
        |> List.map ((+) 1)
        |> List.map (\n -> n > List.length rs |> 0 ? n)
  in
    case msg of
      NoOp ->
        model ! []

      Tick now ->
        { model | rows = roll rows } ! []



--- view ---


view : Model -> Html Msg
view { rows } =
  let
    grid =
      -- dear repo visitor,
      --
      -- below is an experiment in "how much point-free is _too_ much?"
      --
      -- apologies,
      -- brad
      let
        cols =
          List.map (Array.map ("1" ? "0") << Array.initialize (List.length rows) << (==)) rows
      in
        List.range 0 (List.length rows - 1)
          |> List.map (flip List.map cols << Array.get)
          |> (Maybe.combine << List.map Maybe.combine)
          |> Maybe.map (List.map ((\cs -> p [ css [ margin (px 0) ] ] cs) << List.map (\n -> span [] [ text n ])))
          |> Maybe.map (\rs -> div [] rs)
          |> Maybe.withDefault (text "")
  in
    div [ id "main", css [ fontFamilies [ "Ubuntu Mono" ], fontFamily monospace, textAlign center ] ]
      [ stylesheet "https://fonts.googleapis.com/css?family=Ubuntu+Mono:400,700"
      , div [ id "masthead" ]
        [ h1 [] [ text "these8bits" ]
        ]
      , grid
      , div [ id "links" ]
        [ p [] [ a [ href "https://github.com/bchase" ] [ text "GitHub" ] ]
        , p [] [ a [ href "mailto:brad@these8bits.com" ] [ text "Contact" ] ]
        ]
      ]



--- view helpers ---


stylesheet : Url -> Html Msg
stylesheet url =
  node "link" [ href url, rel "stylesheet" ] []



--- generic helpers ---


(?) : a -> a -> Bool -> a
(?) true false check =
  if check then
    true
  else
    false
