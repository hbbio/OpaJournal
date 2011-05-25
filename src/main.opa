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

db /class : intmap(class)
db /event : intmap(event)
