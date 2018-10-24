module Home exposing (init, subscriptions, update, view)

import Css exposing (..)
import Html.Styled as Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Navigation
import Maybe.Extra as Maybe
import Array
import Time exposing (every, millisecond)
import Ports
import Routes
import Helpers exposing ((?))
import Types exposing (Model, Msg(..), Page(..), Url, Path)


--- init / subscriptions ---


init : Navigation.Location -> ( Model, Cmd Msg )
init loc =
  let
    model =
      Model Homepage True <| List.reverse [ 0, 1, 2, 3, 4, 5, 6, 7 ]
  in
    model
      ! [ Ports.styleBody bodyStyles
        -- , Routes.navigateBy loc
        ]


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.batch
    [ every (750 * millisecond) FlashCursor
    , every (450 * millisecond) RollAnimation
    ]



--- update ---


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ cursor, rows } as model) =
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

      RollAnimation _ ->
        { model | rows = roll rows } ! []

      FlashCursor _ ->
        { model | cursor = not cursor } ! []

      ChangePage page ->
        model ! [ Routes.navigateTo page ]

      SetLocation loc ->
        { model | page = Routes.navLocationToPage loc } ! []



--- view ---


bodyStyles =
  "background-color: #000"


view : Model -> Html Msg
view ({ page } as model) =
  case page of
    Homepage ->
      homepage model

    Portfolio ->
      portfolio

    _ ->
      pageNotFound


pageNotFound : Html Msg
pageNotFound =
  text "page not found"


portfolio : Html Msg
portfolio =
  text "portfolio"


homepage : Model -> Html Msg
homepage { cursor, rows } =
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
          |> Maybe.map (\rs -> div [] <| List.map ((\cs -> p [ css [ margin (px 0) ] ] cs) << List.map (\n -> span [] [ text n ])) rs)
          |> Maybe.withDefault (text "")

    orange =
      hex "ff7f00"

    styles =
      css
        [ fontFamilies [ "Ubuntu Mono", monospace.value ]
        , textAlign center
        , color orange
        , fontSize <| Css.em 1.5
        ]

    cursorStyles =
      if cursor then
        [ backgroundColor <| hex "ff7f00", color <| hex "000" ]
      else
        [ backgroundColor <| hex "000", color <| hex "ff7f00" ]

    -- hr_ =
    --   div [ css [ borderTop3 (px 2) solid orange, Css.width (pct 50), margin2 zero auto, marginTop (Css.em 1) ] ] []
  in
    div [ id "main", styles ]
      [ stylesheet "https://fonts.googleapis.com/css?family=Ubuntu+Mono:400,700"
      , div [ id "masthead" ]
        [ h1 []
          [ text "$ these8bit"
          , span [ css cursorStyles ] [ text "s" ]
          ]
        ]
      , div [ id "links" ]
        [ p []
          [ a [ href "https://www.codementor.io/bchase" ] [ text "Codementor" ]
          , text " | "
          , a [ href "https://github.com/bchase" ] [ text "GitHub" ]
          , text " | "
          , a [ href "mailto:brad@these8bits.com" ] [ text "Contact" ]
          ]
        ]
      , div [ css [ marginTop (Css.em 2) ] ] [ grid ]
      ]



--- view helpers ---


stylesheet : Url -> Html Msg
stylesheet url =
  node "link" [ href url, rel "stylesheet" ] []
