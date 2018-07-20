module View.Alarm exposing (armedAlarm, disarmedAlarm, triggeredAlarm)

import Html exposing (Html, div, p, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)


armedAlarm : msg -> Bool -> Html msg
armedAlarm disarmMsg allowAction =
    div
        []
        [ p [] [ text "ARMED" ]
        , (if allowAction == True then
            button [ onClick disarmMsg ] [ text "Disarm" ]
           else
            p [] [ text "Alarm can not be changed until the door is closed" ]
          )
        ]


disarmedAlarm : msg -> Bool -> Html msg
disarmedAlarm armMsg allowAction =
    div
        []
        [ p [] [ text "DISARMED" ]
        , (if allowAction == True then
            button [ onClick armMsg ] [ text "Arm" ]
           else
            p [] [ text "Alarm can not be changed until the door is closed" ]
          )
        ]


triggeredAlarm : msg -> Bool -> Html msg
triggeredAlarm disarmMsg allowAction =
    div
        [ class "triggered" ]
        [ p [] [ text "TRIGGERED!" ]
        , (if allowAction == True then
            button [ onClick disarmMsg ] [ text "Disarm" ]
           else
            p [] [ text "Alarm can not be changed until the door is closed" ]
          )
        ]
