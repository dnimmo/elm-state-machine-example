module View.Alarm exposing (armedAlarm, disarmedAlarm, triggeredAlarm)

import Html exposing (Html, div, p, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)


armedAlarm : msg -> Html msg
armedAlarm disarmMsg =
    div
        []
        [ p [] [ text "ARMED" ]
        , button [ onClick disarmMsg ] [ text "Disarm" ]
        ]


disarmedAlarm : msg -> Html msg
disarmedAlarm armMsg =
    div
        []
        [ p [] [ text "DISARMED" ]
        , button [ onClick armMsg ] [ text "Arm" ]
        ]


triggeredAlarm : msg -> Html msg
triggeredAlarm disarmMsg =
    div
        [ class "triggered" ]
        [ p [] [ text "TRIGGERED!" ]
        , button [ onClick disarmMsg ] [ text "Disarm" ]
        ]
