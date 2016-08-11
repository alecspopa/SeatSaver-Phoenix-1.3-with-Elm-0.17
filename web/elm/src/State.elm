port module State exposing (initialState, update, subscriptions)

import Types exposing (..)

initialState : ((List Seat), Cmd Msg)
initialState =
    ([], Cmd.none)

-- UPDATE

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
