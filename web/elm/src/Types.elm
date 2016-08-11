module Types exposing (..)

-- MODEL

type alias Seat =
  { seatNo: Int
  , occupied: Bool
  }

-- MSG

type Msg
  = RequestSeat Seat
  | UpdatedSeat Seat
  | SetSeats (List Seat)
