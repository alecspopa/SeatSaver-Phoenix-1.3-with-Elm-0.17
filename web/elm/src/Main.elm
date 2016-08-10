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
    = RequestSeat Seat
    | UpdatedSeat Seat
    | SetSeats (List Seat)

update : Msg -> (List Seat) -> ((List Seat), Cmd Msg)
update msg seats =
    case msg of
        RequestSeat seat ->
            (seats, seatsToJs seat)
        UpdatedSeat seatUpdated ->
            let
                seat seatFromSeats =
                    if seatFromSeats.seatNo == seatUpdated.seatNo then
                        seatUpdated
                    else
                        seatFromSeats
            in
                (List.map seat seats, Cmd.none)
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
        , onClick (RequestSeat seat)
        ]
        [ text (toString seat.seatNo) ]

-- PORTS

port seatsFromJs : (List Seat -> msg) -> Sub msg
port seatUpdatedFromJs : (Seat -> msg) -> Sub msg

port seatsToJs : Seat -> Cmd msg

-- SUBSCRIPTIONS

subscriptions : (List Seat) -> Sub Msg
subscriptions seats =
    Sub.batch
        [ seatsFromJs SetSeats
        , seatUpdatedFromJs UpdatedSeat
        ]
