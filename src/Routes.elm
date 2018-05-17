module Routes exposing (navLocationToPage, navigateTo, navigateBy)

import List.Extra as List
import Navigation
import Helpers exposing ((?))
import Types exposing (Path, Page(..), Msg(SetLocation))


navLocationToPage : Navigation.Location -> Page
navLocationToPage =
  routing.toPage << .pathname


navigateTo : Page -> Cmd Msg
navigateTo =
  Navigation.newUrl << routing.toPath


navigateBy : Navigation.Location -> Cmd Msg
navigateBy { hostname, pathname } =
  case ( hostname, pathname ) of
    ---- ELM REACTOR ----
    ( "localhost", "/index.html" ) ->
      navigateTo Homepage

    _ ->
      navigateTo << routing.toPage <| pathname



--- private ---


routing : { toPage : Path -> Page, toPath : Page -> Path }
routing =
  let
    routes : Page -> ( Path, Page )
    routes page =
      case page of
        Homepage as page ->
          ( "/", page )

        Portfolio as page ->
          ( "/portfolio", page )

        PageNotFound as page ->
          ( "/404", page )

    routesList : List ( Path, Page )
    routesList =
      let
        routeTotalityCheck =
          -- -- ATTENTION -- --
          -- this `case` exists to help check route totality.
          -- if you're here because of an error, please add
          -- the new `Page` to the `case` and `routes` below.
          case PageNotFound of
            Homepage ->
              ()

            Portfolio ->
              ()

            PageNotFound ->
              ()
      in
        [ routes Homepage
        , routes Portfolio
        , routes PageNotFound
        ]

    toPath =
      Tuple.first << routes

    toPage path =
      routesList
        |> List.find ((==) path << Tuple.first)
        |> Maybe.map Tuple.second
        |> Maybe.withDefault PageNotFound
  in
    { toPath = toPath
    , toPage = toPage
    }
