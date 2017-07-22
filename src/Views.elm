module Src.Views exposing (..)

import Html
import Html.Attributes as Attributes

import Src.Models as Models

view : Models.Model -> Html.Html Models.Msg
view model = Html.div
    [ Attributes.style
        [ ("width", "100%")
        ]
    ]
    [ headerView
    , Html.hr [] []
    , introductionView
    , linksView
    ]

headerView : Html.Html Models.Msg
headerView = Html.div
    [ Attributes.style
        [ ("width", "100%")
        , ("text-align", "center")
        , ("font-weight", "bold")
        , ("font-size", "40px")
        ]
    ]
    [ Html.text "Welcome to the Elm Study Group Landing Page" ]

introductionView : Html.Html Models.Msg
introductionView = Html.div
    [ Attributes.style [ ("width", "100%") ] ]
    [ Html.p
        [ Attributes.style
            [ ("width", "100%")
            , ("text-align", "center")
            , ("font-size", "18px")
            ]
        ]
        [ Html.text "From weeks 4 on, the homework will be building actual web-apps, rather than toy functions." ]
    , Html.p
        [ Attributes.style
            [ ("width", "100%")
            , ("text-align", "center")
            , ("font-size", "18px")
            ]
        ]
        [ Html.text "This page acts as a landing page to forward you on to the pages you'll write for the homework." ]
    ]

linksView : Html.Html Models.Msg
linksView = Html.div
    [ Attributes.style
        [ ("width", "250px")
        , ("text-align", "left")
        , ("margin", "0 auto")
        , ("font-size", "18px")
        ]
    ]
    [ Html.ul []
        [ Html.li []
            [ Html.a [ Attributes.href "#week4"] [ Html.text "Week 4" ]
            , Html.text "("
            , Html.a [ Attributes.href "#week4/solution"] [ Html.text "Solution" ]
            , Html.text ")"
            ]
        , Html.li []
            [ Html.a [ Attributes.href "#week5"] [ Html.text "Week 5" ]
            , Html.text "("
            , Html.a [ Attributes.href "#week5/solution"] [ Html.text "Solution" ]
            , Html.text ")"
            ]
--        , Html.li []
--            [ Html.a [ Attributes.href "#week6"] [ Html.text "Week 6" ]
--            , Html.text "("
--            , Html.a [ Attributes.href "#week6/solution"] [ Html.text "Solution" ]
--            , Html.text ")"
--            ]
        ]
    ]

