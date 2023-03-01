
(define (problem p4-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-1-1 loc-2-1 loc-3-1 loc-4-1 loc-5-1 loc-6-1 loc-7-1 - location
    key1 key2 key3 key4 key5 key6 - key
    c1121 c2131 c3141 c4151 c5161 c6171 - corridor
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-1-1)
    (free-arm)  ; initally, holding no keys
   
    ; Locating <> Corridor Connections
    ; corridors go both ways (fwd and back)
    (is-corr loc-1-1 c1121 loc-2-1)
    (is-corr loc-2-1 c2131 loc-3-1)
    (is-corr loc-3-1 c3141 loc-4-1)
    (is-corr loc-4-1 c4151 loc-5-1)
    (is-corr loc-5-1 c5161 loc-6-1)
    (is-corr loc-6-1 c6171 loc-7-1)
    
    (is-corr loc-2-1 c1121 loc-1-1)
    (is-corr loc-3-1 c2131 loc-2-1)
    (is-corr loc-4-1 c3141 loc-3-1)
    (is-corr loc-5-1 c4151 loc-4-1)
    (is-corr loc-6-1 c5161 loc-5-1)
    (is-corr loc-7-1 c6171 loc-6-1)
    
    
    
    ; corridors with locks connected to rooms so you can only unlock when in an adjacent room
    (conn-corr loc-1-1 c1121)
    (conn-corr loc-2-1 c2131)
    (conn-corr loc-3-1 c3141)
    (conn-corr loc-4-1 c4151)
    (conn-corr loc-5-1 c5161)
    (conn-corr loc-6-1 c6171)

    ; Key locations
    (key-at loc-1-1 key1)
    (key-at loc-1-1 key2)
    (key-at loc-1-1 key3)
    (key-at loc-1-1 key4)
    (key-at loc-1-1 key5)
    (key-at loc-1-1 key6)
    
    ; Locked corridors
    (is-locked c1121)
    (is-locked c2131)
    (is-locked c3141)
    (is-locked c4151)
    (is-locked c5161)
    (is-locked c6171)
    
    (is-locked-col c6171 rainbow)
    (is-locked-col c1121 purple)
    (is-locked-col c5161 red)
    (is-locked-col c2131 yellow)
    (is-locked-col c3141 green)
    (is-locked-col c4151 green)
    
    ; Risky corridors
    (risky c6171)

    ; Key colours
    (key-col key1 red)
    (key-col key2 yellow)
    (key-col key3 rainbow)
    (key-col key4 purple)
    (key-col key5 green)
    (key-col key6 green)

    ; Key usage properties (one use, two use, etc)
    ; Each key assigned a certain number of uses (doesn't matter for infite use keys)
    (uses2 key2)
    (uses1 key3)
    (uses1 key4)
    (uses1 key5)
    (uses1 key6)

  )
  (:goal
    (and
      ; Hero's final location
      (hero-at loc-7-1)
    )
  )

)