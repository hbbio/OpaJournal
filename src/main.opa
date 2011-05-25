// author: Henri Binsztok
// copyright: MLstate
// license: AGPL

type class = 
     { name : string }

type counter =
     { value : int }

type event = 
     { date : Date.date
     ; class : int
     ; user : option(string)
     }

type condition = { classis : int } / { useris : string } / { before : Date.date } / { after : Date.date }
// TODO: and, or
type clause = list(condition)
// if clause then increment(counter)
type trigger =
     { clause : clause
     ; counter : string }

db /class : intmap(class)
db /counter : stringmap(counter)
db /event : intmap(event)

