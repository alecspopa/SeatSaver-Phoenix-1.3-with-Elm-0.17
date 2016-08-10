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

init : ((List Seat), Cmd Msg)
init =
    ([], Cmd.none)

-- UPDATE

type Msg
    = Toogle Seat
    | SetSeats (List Seat)

update : Msg -> (List Seat) -> ((List Seat), Cmd Msg)
update msg seats =
    case msg of
        Toogle seatToToggle ->
            let updateSeat seatFromSeats =
                if seatFromSeats.seatNo == seatToToggle.seatNo then
                    { seatFromSeats | occupied = not seatFromSeats.occupied }
                else seatFromSeats
            in
                (List.map updateSeat seats, Cmd.none)
        SetSeats seats ->
            (seats, Cmd.none)

-- VIEW

view : (List Seat) -> Html Msg
view seats =
    ul [ class "seats" ] (List.map seatItem seats)

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

port seatsFromJs : (List Seat -> msg) -> Sub msg

-- SUBSCRIPTIONS

subscriptions : (List Seat) -> Sub Msg
subscriptions seats =
    seatsFromJs SetSeats
