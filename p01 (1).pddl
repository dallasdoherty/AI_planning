(define (problem p1-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-3-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 loc-3-3 loc-2-4 loc-3-4 loc-4-4 - location
    key1 key2 key3 key4 - key
    c3132 c1222 c2232 c3242 c2223 c3233 c2333 c2324 c3334 c2434 c3444 - corridor
  )

  (:init

    ; Hero location and carrying status
    (at loc-1-2)
    (free ?arm)

    ; Locating <> Corridor Connections
    (connected loc-3-1 c3132 loc-3-2)
    (connected loc-1-2 c1222 loc-2-2)
    (connected loc-2-2 c2232 loc-2-3)
    (connected loc-3-2 c3233 loc-3-3)
    (connected loc-2-3 c2223 loc-2-4)
    (connected loc-3-3 c2333 loc-3-4)
    (connected loc-4-2 c3242 loc-4-3)
    (connected loc-3-4 c3334 loc-4-4)
    (connected loc-2-4 c2434 loc-2-3)
    (connected loc-4-4 c3444 loc-3-4)

    ; Key locations
    (at key1 loc-2-2)
    (at key2 loc-2-4)
    (at key3 loc-4-2)
    (at key4 loc-4-4)

    ; Locked corridors
    (locked c3132)
    (locked c3242)
    (locked c2324)
    (locked c2434)
    (locked c3444)

    ; Risky corridors
    (risky c2324)
    (risky c2434)

    ; Key colours
    (colour key1 red)
    (colour key2 yellow)
    (colour key3 rainbow)
    (colour key4 purple)

    ; Key usage properties (one use, two use, etc)
    (key-usage key1 infinite)
    (key-usage key2 2)
    (key-usage key3 1)
    (key-usage key4 1)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (at loc-3-1)
    )
  )

)

