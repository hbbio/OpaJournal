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
     ; description : string
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
db /events : list(event)
db /trigger : list(trigger)

Class = {{
  set(id, name) =
    do /class/id <- name
}}

Counter = {{
  incr(name) =
    do /counter/name <- /counter/name + 1
}}

Trigger = {{
}}

Event = {{
  add(class, user, description) =
    event <- { date = Date.now() ; ~class ; ~user ; ~description }
    do /events <- [ event | /events ]
}}
