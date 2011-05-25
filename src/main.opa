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

type condition = { class : int } / { user : string } / { before : Date.date } / { after : Date.date }
// TODO: and, or
type clause = list(condition)
// if clause then increment(counter)
type trigger =
     { clause : clause
     ; counter : string }

db /class : intmap(class)
db /counter : stringmap(counter)
db /events : list(event)
db /triggers : list(trigger)

Class = {{
  set(id, name) =
    do /class/id <- name
}}

Counter = {{
  incr(name) =
    do /counter/name <- /counter/name + 1
}}

Trigger = {{
  check_condition(event, condition) =
    match condition
    | { ~class } -> class == event.class
    | { ~user} -> user == event.user
    | { ~before } -> event.date < before
    | { ~after } -> event.date > after
  check_clause(event, clause) =
    f(condition, acc) = acc && check(event, condition)
    List.fold(f, clause, true)
  apply(event, trigger) =
    if check_clause(event, trigger.clause) then
      Counter.incr(trigger.counter)
}}

Event = {{
  add(class, user, description) =
    event <- { date = Date.now() ; ~class ; ~user ; ~description }
    do /events <- [ event | /events ]
    do List.iter(Trigger.apply(event), /triggers)
}}
