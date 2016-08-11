module View exposing (rootView)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Types exposing (..)

rootView : (List Seat) -> Html Msg
rootView seats =
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
