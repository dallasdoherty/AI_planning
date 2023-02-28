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

    ; Locationg <> Corridor Connections
    (is-corr loc-1-2 c1222 loc-2-2)

    ; Key locations
    (key-at loc-1-2 key1)

    ; Locked corridors
    (is-locked-col c1222 red)
    (is-locked c1222)

    ; Risky corridors
    ; (risky c1222)

    ; Key colours
    (key-col key1 red)
    (no-key key1)

    ; Key usage properties (one use, two use, etc)
    ; (uses key1)
    ; (uses2 key2)
    ; (uses1 key3)
    ; (uses1 key4)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (hero-at loc-2-2)
    )
  )

)