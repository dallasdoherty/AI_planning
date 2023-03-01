
(define (problem p3-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-3-4 loc-4-5 loc-1-2 loc-2-2 loc-3-2 loc-3-3 loc-2-5 loc-1-3 loc-2-1 loc-1-4 loc-3-5 loc-2-4 loc-4-4 loc-2-3 loc-4-3 - location
    c2122 c1222 c2232 c1213 c1223 c2223 c3223 c3233 c1323 c2333 c1314 c2314 c2324 c2334 c3334 c1424 c2434 c2425 c2535 c3545 c4544 c4443 - corridor
    key1 key2 key3 key4 key5 key6 - key
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-2-1)
    (free-arm)
    ; Locationg <> Corridor Connections
    (is-corr loc-2-1 c2122 loc-2-2)
    (is-corr loc-2-2 c2232 loc-3-2)
    (is-corr loc-1-2 c1222 loc-2-2)
    (is-corr loc-1-2 c1213 loc-1-3)
    (is-corr loc-1-2 c1223 loc-2-3)
    (is-corr loc-2-2 c2223 loc-2-3)
    (is-corr loc-3-2 c3223 loc-2-3)
    (is-corr loc-3-2 c3233 loc-3-3)
    (is-corr loc-1-3 c1323 loc-2-3)
    (is-corr loc-2-3 c2314 loc-1-4)
    (is-corr loc-2-3 c2333 loc-3-3)
    (is-corr loc-1-3 c1314 loc-1-4)
    (is-corr loc-2-3 c2324 loc-2-4)
    (is-corr loc-2-3 c2334 loc-3-4)
    (is-corr loc-3-3 c3334 loc-3-4)
    (is-corr loc-1-4 c1424 loc-2-4)
    (is-corr loc-2-4 c2434 loc-3-4)
    (is-corr loc-2-4 c2425 loc-2-5)
    (is-corr loc-2-5 c2535 loc-3-5)
    (is-corr loc-3-5 c3545 loc-4-5)
    (is-corr loc-4-5 c4544 loc-4-4)
    (is-corr loc-4-4 c4443 loc-4-3)

    (is-corr loc-2-2 c2122 loc-2-1)
    (is-corr loc-3-2 c2232 loc-2-2)
    (is-corr loc-2-2 c1222 loc-1-2)
    (is-corr loc-1-3 c1213 loc-1-2)
    (is-corr loc-2-3 c1223 loc-1-2)
    (is-corr loc-2-3 c2223 loc-2-2)
    (is-corr loc-2-3 c3223 loc-3-2)
    (is-corr loc-3-3 c3233 loc-3-2)
    (is-corr loc-2-3 c1323 loc-1-3)
    (is-corr loc-1-4 c2314 loc-2-3)
    (is-corr loc-3-3 c2333 loc-2-3)
    (is-corr loc-1-4 c1314 loc-1-3)
    (is-corr loc-2-4 c2324 loc-2-3)
    (is-corr loc-3-4 c2334 loc-2-3)
    (is-corr loc-3-4 c3334 loc-3-3)
    (is-corr loc-2-4 c1424 loc-1-4)
    (is-corr loc-3-4 c2434 loc-2-4)
    (is-corr loc-2-5 c2425 loc-2-4)
    (is-corr loc-3-5 c2535 loc-2-5)
    (is-corr loc-4-5 c3545 loc-3-5)
    (is-corr loc-4-4 c4544 loc-4-5)
    (is-corr loc-4-3 c4443 loc-4-4)

    ; connected corridors
    (conn-corr loc-2-3 c1223)
    (conn-corr loc-2-3 c2223)
    (conn-corr loc-2-3 c2324)
    (conn-corr loc-2-3 c2334)
    (conn-corr loc-2-3 c1323)
    (conn-corr loc-2-3 c2333)
    (conn-corr loc-2-3 c1323)
    (conn-corr loc-2-3 c2314)
    (conn-corr loc-2-4 c2324)
    (conn-corr loc-1-3 c1323)
    (conn-corr loc-1-4 c2314)
    (conn-corr loc-4-5 c3545)
    (conn-corr loc-3-3 c2333)
    (conn-corr loc-2-4 c2425)
    (conn-corr loc-2-5 c2425)
    (conn-corr loc-3-5 c3545)
    (conn-corr loc-2-5 c2535)
    (conn-corr loc-3-5 c2535)
    (conn-corr loc-4-5 c4544)
    (conn-corr loc-1-2 c1223)
    (conn-corr loc-4-4 c4544)
    (conn-corr loc-4-4 c4443)
    (conn-corr loc-2-3 c3223)
    (conn-corr loc-3-2 c3223);
    (conn-corr loc-3-4 c2334)
    (conn-corr loc-2-2 c2223)
    


    ; Key locations
    (key-at loc-2-1 key1)
    (key-at loc-2-3 key2)
    (key-at loc-2-3 key3)
    (key-at loc-2-3 key4)
    (key-at loc-2-3 key5)
    (key-at loc-4-4 key6)

    ; Locked corridors
    (is-locked c2425)
    (is-locked c2535)
    (is-locked c2334)
    (is-locked c3223)
    (is-locked c1323)
    (is-locked c2333)
    (is-locked c4443)
    (is-locked c4544)
    (is-locked c2223)
    (is-locked c2314)
    (is-locked c2324)
    (is-locked c3545)
    (is-locked c1223)

    ; colour of locked corridors 
    (is-locked-col c1323 red)
    (is-locked-col c3223 red)
    (is-locked-col c2333 red)
    (is-locked-col c1223 red)
    (is-locked-col c2223 red)
    (is-locked-col c2334 red)
    (is-locked-col c2314 red)
    (is-locked-col c2324 red)
    (is-locked-col c2425 purple)
    (is-locked-col c2535 green)
    (is-locked-col c3545 purple)
    (is-locked-col c4443 rainbow)
    (is-locked-col c4544 green)

    ; Risky corridors
    (risky c1223)
    (risky c2324)
    (risky c2334)
    (risky c3223)
    (risky c2223)
    (risky c2333)
    (risky c1323)
    (risky c2314)

    ; Key colours
    (key-col key1 red)
    (key-col key2 green)
    (key-col key3 green)
    (key-col key4 purple)
    (key-col key5 purple)
    (key-col key6 rainbow)

    ; Key usage properties (one use, two use, etc)
    (uses1 key2)
    (uses1 key3)
    (uses1 key4)
    (uses1 key5)
    (uses1 key6)
  )
  (:goal
    (and
      (hero-at loc-4-3)
    )
  )

)