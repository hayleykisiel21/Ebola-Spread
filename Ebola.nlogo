turtles-own
  [ sick?                ;; if true, the turtle is infectious
    remaining-immunity   ;; how many dayss of immunity the turtle has left
    sick-time            ;; how long, in days, the turtle has been infectious

]

globals
  [ %infected            ;; what % of the population is infectious
    %immune              ;; what % of the population is immune
]

to setup
  clear-all
  setup-turtles
  update-global-variables
  update-display
  ask patch 7 7 [ set pcolor red]
  let total-population count turtles
  reset-ticks
end

to setup-turtles
  create-turtles number-people
    [ setxy random-xcor random-ycor
      set size 1
      get-healthy ]
end

to get-sick ;; turtle procedure
  set sick? true
  set remaining-immunity 0

  end

to get-healthy ;; turtle procedure
  set sick? false
  set sick-time 0
  set remaining-immunity 0
end

to become-immune ;; turtle procedure
  set sick? false
  set sick-time 0
  set remaining-immunity 365
end

to go
  ask turtles [
    get-older
    move
    if [ pcolor ] of patch-here = red [ get-sick ]
    if sick? [ infect recover-or-die ]
  ]

  update-global-variables
  update-display
  tick
end

to update-global-variables
  if count turtles > 0
    [ set %infected (count turtles with [ sick? ] / count turtles) * 100
      set %immune (count turtles with [ immune? ] / count turtles) * 100]
      ;set]
end

to update-display
  ask turtles
    [ if shape != turtle-shape [ set shape turtle-shape ]
      set color ifelse-value sick? [ red ] [ ifelse-value immune? [ blue ] [ green ] ] ]
end

;;Turtle counting variables are advanced.


to get-older ;; turtle procedure
  if remaining-immunity = 1 [ get-healthy ]
  if immune? [ set remaining-immunity remaining-immunity - 1 ]
  if sick? [ set sick-time sick-time + 1 ]
end

;; Turtles move about at random.

to move ;; turtle procedure
  rt random 100
  lt random 100
  fd 1
end

;; If a turtle is sick, it infects other turtles on the same patch.
;; Immune turtles don't get sick.

to infect ;; turtle procedure
  ask other turtles-here with [ not sick? and not immune? ]
    ;[ if random-float 30 < vaccine
      [ get-sick ]; ]
end

to recover-or-die ;; turtle procedure
   if sick-time > 5
    [ ifelse random-float 30 < medical_attention
      [ become-immune ]
      [ die ] ]

end

to-report immune?
  report remaining-immunity > 0
end





;; This model is a modified version of NetLogo Virus model (Wilensky, U)
;; to represent to the Ebola virus 

## CREDITS AND REFERENCES

VIRUS MODEL:

* Wilensky, U. (1998).  NetLogo Virus model.  http://ccl.northwestern.edu/netlogo/models/Virus.  Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.



