
(define (problem p2-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-2-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 - location
    key1 key2 key3 key4 - key
    c2122 c1222 c2232 c3242 c2223 - corridor
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-2-2)
    (free-arm)

    ; Locationg <> Corridor Connections
    (is-corr loc-1-2 c1222 loc-2-2)
    (is-corr loc-2-2 c2232 loc-3-2)
    (is-corr loc-3-2 c3242 loc-4-2)
    (is-corr loc-2-1 c2122 loc-2-2)
    (is-corr loc-2-2 c2223 loc-2-3)

    (is-corr loc-2-2 c1222 loc-1-2)
    (is-corr loc-3-2 c2232 loc-2-2)
    (is-corr loc-4-2 c3242 loc-3-2)
    (is-corr loc-2-2 c2122 loc-2-1)
    (is-corr loc-2-3 c2223 loc-2-2)

    ; corridors with locks connected to rooms so you can only unlock when in an adjacent room
    (conn-corr loc-2-2 c2232)
    (conn-corr loc-2-2 c1222)
    (conn-corr loc-2-2 c2223)
    (conn-corr loc-2-1 c2122)
    (conn-corr loc-3-2 c2232)
    (conn-corr loc-2-3 c2223)
    (conn-corr loc-3-2 c3242)
    (conn-corr loc-1-2 c1222)
    (conn-corr loc-2-2 c2122)

    ; Key locations
    (key-at loc-2-1 key1)
    (key-at loc-1-2 key2)
    (key-at loc-2-2 key3)
    (key-at loc-2-3 key4)

    ; Locked corridors
    (is-locked c1222)
    (is-locked c2232)
    (is-locked c2122)
    (is-locked c3242)
    (is-locked c2223)

    (is-locked-col c1222 yellow)
    (is-locked-col c2232 yellow)
    (is-locked-col c2122 purple)
    (is-locked-col c3242 rainbow)
    (is-locked-col c2223 green)

    ; Risky corridors

    ; Key colours
    (key-col key1 green)
    (key-col key2 rainbow)
    (key-col key3 purple)
    (key-col key4 yellow)

    ; Key usage properties (one use, two use, etc)
    (uses1 key1)
    (uses1 key2)
    (uses1 key3)
    (uses2 key4)

  )
  (:goal
    (and
      (hero-at loc-4-2)
    )
  )

)