module View.Door exposing (openDoor, closedDoor, lockedDoor)

import Html exposing (Html, div, p, button, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


openDoor : msg -> Html msg
openDoor closeMsg =
    div
        []
        [ div
            [ class "door open" ]
            [ p
                []
                [ text "The door is open" ]
            ]
        , button
            [ onClick closeMsg ]
            [ text "Close" ]
        ]


closedDoor : msg -> msg -> Html msg
closedDoor openMsg lockMsg =
    div []
        [ div
            [ class "door closed" ]
            [ p
                []
                [ text "The door is closed " ]
            ]
        , button
            [ onClick lockMsg ]
            [ text "Lock" ]
        , button
            [ onClick openMsg ]
            [ text "Open" ]
        ]


lockedDoor : msg -> Html msg
lockedDoor unlockMsg =
    div
        []
        [ div
            [ class "door locked" ]
            [ p
                []
                [ text "The door is locked" ]
            ]
        , button
            [ onClick unlockMsg ]
            [ text "Unlock" ]
        ]
