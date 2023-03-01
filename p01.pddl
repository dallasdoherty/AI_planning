
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
    (hero-at loc-1-2)
    (free-arm)  ; initally, holding no keys
   
    ; Locating <> Corridor Connections
    ; corridors go both ways (fwd and back)
    (is-corr loc-3-1 c3132 loc-3-2)
    (is-corr loc-1-2 c1222 loc-2-2)
    (is-corr loc-2-2 c2232 loc-3-2)
    (is-corr loc-3-2 c3233 loc-3-3)
    (is-corr loc-2-2 c2223 loc-2-3)
    (is-corr loc-2-3 c2333 loc-3-3)
    (is-corr loc-3-2 c3242 loc-4-2)
    (is-corr loc-3-3 c3334 loc-3-4)
    (is-corr loc-2-3 c2324 loc-2-4)
    (is-corr loc-2-4 c2434 loc-3-4)
    (is-corr loc-3-4 c3444 loc-4-4)
    
    (is-corr loc-3-2 c3132 loc-3-1)
    (is-corr loc-2-2 c1222 loc-1-2)
    (is-corr loc-3-2 c2232 loc-2-2)
    (is-corr loc-3-3 c3233 loc-3-2)
    (is-corr loc-2-3 c2223 loc-2-2)
    (is-corr loc-3-3 c2333 loc-2-3)
    (is-corr loc-4-2 c3242 loc-3-2)
    (is-corr loc-3-4 c3334 loc-3-3)
    (is-corr loc-2-4 c2324 loc-2-3)
    (is-corr loc-3-4 c2434 loc-2-4)
    (is-corr loc-4-4 c3444 loc-3-4)
    
    ; corridors with locks connected to rooms so you can only unlock when in an adjacent room
    (conn-corr loc-2-3 c2324)
    (conn-corr loc-2-4 c2434)
    (conn-corr loc-2-4 c2324)
    (conn-corr loc-3-4 c2434)
    (conn-corr loc-3-2 c3242)
    (conn-corr loc-3-4 c3444)
    (conn-corr loc-3-2 c3132)

    ; Key locations
    (key-at loc-2-2 key1)
    (key-at loc-2-4 key2)
    (key-at loc-4-2 key3)
    (key-at loc-4-4 key4)
    
    ; Locked corridors
    (is-locked c3132)
    (is-locked c3242)
    (is-locked c2324)
    (is-locked c2434)
    (is-locked c3444)
    
    (is-locked-col c3132 rainbow)
    (is-locked-col c3242 purple)
    (is-locked-col c2324 red)
    (is-locked-col c2434 red)
    (is-locked-col c3444 yellow)
    
    ; Risky corridors
    (risky c2324)
    (risky c2434)

    ; Key colours
    (key-col key1 red)
    (key-col key2 yellow)
    (key-col key3 rainbow)
    (key-col key4 purple)

    ; Key usage properties (one use, two use, etc)
    ; Each key assigned a certain number of uses (doesn't matter for infite use keys)
    (uses2 key2)
    (uses1 key3)
    (uses1 key4)

  )
  (:goal
    (and
      ; Hero's final location
      (hero-at loc-3-1)
    )
  )

)