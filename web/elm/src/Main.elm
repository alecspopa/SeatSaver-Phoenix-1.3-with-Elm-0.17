port module SeatSaver exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

-- MODEL

type alias Seat =
    { seatNo: Int
    , occupied: Bool
    }

type alias Model =
    List Seat

init : (Model, Cmd Msg)
init =
    ([], Cmd.none)

-- UPDATE

type Msg
    = Toogle Seat
    | SetSeats Model

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Toogle seatToToggle ->
            let updateSeat seatFromModel =
                if seatFromModel.seatNo == seatToToggle.seatNo then
                    { seatFromModel | occupied = not seatFromModel.occupied }
                else seatFromModel
            in
                (List.map updateSeat model, Cmd.none)
        SetSeats seats ->
            (seats, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
    ul [ class "seats" ] (List.map seatItem model)

seatItem : Seat -> Html Msg
seatItem seat =
    let occupiedClass =
        if seat.occupied then "occupied" else "available"
    in
        li
        [ class ("seat " ++ occupiedClass)
        , onClick (Toogle seat)
        ]
        [ text (toString seat.seatNo) ]

-- PORTS

port seatLists : (Model -> msg) -> Sub msg

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    seatLists SetSeats
