module SeatSaver exposing (main)

import Html.App as App

import Types exposing (..)
import State
import View

main : Program Never
main =
    App.program
        { init = State.initialState
        , update = State.update
        , subscriptions = State.subscriptions
        , view = View.rootView
        }
