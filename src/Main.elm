module Main exposing (..)

import View.Door as Door exposing (openDoor, closedDoor, lockedDoor)
import View.Alarm as Alarm exposing (armedAlarm, disarmedAlarm, triggeredAlarm)
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (class)


---- MODEL ----


type Model
    = ViewRoom DoorState AlarmState


type DoorState
    = Opened
    | Closed
    | Locked


type AlarmState
    = Armed
    | Disarmed
    | Triggered


initialModel : Model
initialModel =
    ViewRoom Closed Armed



---- UPDATE ----


type Msg
    = Open
    | Close
    | Lock
    | Unlock
    | Arm
    | Disarm
    | Trigger


update : Msg -> Model -> Model
update msg model =
    case model of
        ViewRoom doorState alarmState ->
            case doorState of
                Opened ->
                    case msg of
                        Close ->
                            ViewRoom Closed alarmState

                        _ ->
                            model

                Closed ->
                    case msg of
                        Open ->
                            case alarmState of
                                Armed ->
                                    ViewRoom Opened Triggered

                                _ ->
                                    ViewRoom Opened alarmState

                        Lock ->
                            ViewRoom Locked alarmState

                        Arm ->
                            ViewRoom Closed Armed

                        Disarm ->
                            ViewRoom Closed Disarmed

                        _ ->
                            model

                Locked ->
                    case msg of
                        Unlock ->
                            ViewRoom Closed alarmState

                        Arm ->
                            ViewRoom Locked Armed

                        Disarm ->
                            ViewRoom Locked Disarmed

                        _ ->
                            model



---- VIEW ----


view : Model -> Html Msg
view model =
    case model of
        ViewRoom doorState alarmState ->
            div
                []
                [ div
                    [ class "doorPanel" ]
                    [ case doorState of
                        Opened ->
                            openDoor Close

                        Closed ->
                            closedDoor Open Lock

                        Locked ->
                            lockedDoor Unlock
                    ]
                , div
                    [ class "alarmPanel " ]
                    [ case alarmState of
                        Armed ->
                            armedAlarm Disarm (doorState /= Opened)

                        Disarmed ->
                            disarmedAlarm Arm (doorState /= Opened)

                        Triggered ->
                            triggeredAlarm Disarm (doorState /= Opened)
                    ]
                ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
