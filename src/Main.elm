module Main exposing (AlarmState(..), DoorState(..), Model(..), Msg(..), initialModel, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, p, text)
import Html.Attributes exposing (class)
import View.Alarm as Alarm exposing (armedAlarm, disarmedAlarm, triggeredAlarm)
import View.Door as Door exposing (closedDoor, lockedDoor, openDoor)



---- MODEL ----


type Model
    = DisplayingRoom DoorState AlarmState
    | Failure String


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
    DisplayingRoom Closed Armed



---- UPDATE ----


type Msg
    = Open
    | Close
    | Lock
    | Unlock
    | Arm
    | Disarm


update : Msg -> Model -> Model
update msg model =
    case model of
        DisplayingRoom doorState alarmState ->
            case doorState of
                Opened ->
                    case msg of
                        Close ->
                            DisplayingRoom Closed alarmState

                        _ ->
                            Failure "unexpected message received while door was in Opened state"

                Closed ->
                    case msg of
                        Open ->
                            case alarmState of
                                Armed ->
                                    DisplayingRoom Opened Triggered

                                _ ->
                                    DisplayingRoom Opened alarmState

                        Lock ->
                            DisplayingRoom Locked alarmState

                        Arm ->
                            DisplayingRoom Closed Armed

                        Disarm ->
                            DisplayingRoom Closed Disarmed

                        _ ->
                            Failure "unexpected message received while door was in Closed state"

                Locked ->
                    case msg of
                        Unlock ->
                            DisplayingRoom Closed alarmState

                        Arm ->
                            DisplayingRoom Locked Armed

                        Disarm ->
                            DisplayingRoom Locked Disarmed

                        _ ->
                            Failure "unexpected message received while door was in Locked state"

        Failure _ ->
            model



---- VIEW ----


failure : String -> Html msg
failure message =
    div []
        [ p [] [ text message ] ]


view : Model -> Html Msg
view model =
    case model of
        Failure message ->
            failure message

        DisplayingRoom doorState alarmState ->
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


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
