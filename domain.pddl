(define (domain Dungeon)

    (:requirements
        :typing
        :negative-preconditions
        :conditional-effects
    )

    ; Do not modify the types
    (:types
        location colour key corridor
    )

    ; Do not modify the constants
    (:constants
        red yellow green purple rainbow - colour
    )

    ; You may introduce whatever predicates you would like to use
    (:predicates

        ; One predicate given for free!
        (hero-at ?loc - location)
        ; Initalize corridors between rooms
        (is-corr ?loc - location ?cor - corridor ?loc - location )
        ; Various predicates for rooms being locked, risky, messy or corridors being collapsed
        (is-locked ?cor - corridor)
        (risky ?cor - corridor)
        (collapsed ?cor - corridor)
        (messy ?loc - location)
        (key-at ?loc -location ?key -key)
        ; Identifies colour of lock
        (is-locked-col ?cor - corridor ?col - colour)
        ; Possible times a key can be uses, modified after unlocking
        (uses0 ?key - key)
        (uses1 ?key - key)
        (uses2 ?key - key)
        (key-col ?key - key ?col - colour)
        ; Whether hero is holding key/has a free arm to pick up another
        (no-key ?key - key)
        (free-arm)
        ; Adjacent rooms with locked corridors
        (conn-corr ?loc - location ?cor - corridor)
        (holding ?key - key)

    )

    ; IMPORTANT: You should not change/add/remove the action names or parameters

    ;Hero can move if the
    ;    - hero is at current location ?from,
    ;    - hero will move to location ?to,
    ;    - corridor ?cor exists between the ?from and ?to locations
    ;    - there isn't a locked door in corridor ?cor
    ;Effects move the hero, and collapse the corridor if it's "risky" (also causing a mess in the ?to location)
    (:action move

        :parameters (?from ?to - location ?cor - corridor)

        :precondition (and
            ; Hero is at location, and can move through a stable corridor
            (hero-at ?from) 
            (not(hero-at ?to))
            (is-corr ?from ?cor ?to)   
            (not (is-locked ?cor))     
            (not (collapsed ?cor))              

        )

        :effect (and
            ; Remove hero from previous location, set at new location
            (not(hero-at ?from))
            (hero-at ?to)
            ; Collapse risky corridors
            (when (and (risky ?cor)) (and (messy ?to) (collapsed ?cor) ))
        )
    )

    ;Hero can pick up a key if the
    ;    - hero is at current location ?loc,
    ;    - there is a key ?k at location ?loc,
    ;    - the hero's arm is free,
    ;    - the location is not messy
    ;Effect will have the hero holding the key and their arm no longer being free
    (:action pick-up

        :parameters (?loc - location ?k - key)

        :precondition (and
        ; Pick up if arm is free and not holding a key (and room is clean)
        (hero-at ?loc)
        (key-at ?loc ?k)
        (free-arm)
        (not(holding ?k))
        (not(messy ?loc))           

        )

        :effect (and
            (not(free-arm))
            (holding ?k)
            ; Remove the key from position so it can't be picked up again
            (not(key-at ?loc ?k))

        )
    )

    ;Hero can drop a key if the
    ;    - hero is holding a key ?k,
    ;    - the hero is at location ?loc
    ;Effect will be that the hero is no longer holding the key
    (:action drop

        :parameters (?loc - location ?k - key)

        :precondition (and
            ; Allowable drop 
            (holding ?k)
            (not(free-arm))
            (hero-at ?loc)

        )

        :effect (and
            ; Free arm and set key at new location
            (free-arm)
            (not(holding ?k))
            (key-at ?loc ?k)

        )
    )


    ;Hero can use a key for a corridor if
    ;    - the hero is holding a key ?k,
    ;    - the key still has some uses left,
    ;    - the corridor ?cor is locked with colour ?col,
    ;    - the key ?k is if the right colour ?col,
    ;    - the hero is at location ?loc
    ;    - the corridor is connected to the location ?loc
    ;Effect will be that the corridor is unlocked and the key usage will be updated if necessary
    (:action unlock

        :parameters (?loc - location ?cor - corridor ?col - colour ?k - key)

        :precondition (and
            ; Unlock a lock if key and lock have the same corridor and here is in adjacent room
            (hero-at ?loc) 
            (holding ?k)
            (not(free-arm))
            (not(uses0 ?k))                       
            (is-locked ?cor)
            (is-locked-col ?cor ?col)
            (key-col ?k ?col)
            (conn-corr ?loc ?cor)

        )

        :effect (and
            ; Decrease uses if it's a finite use key
            (not(is-locked-col ?cor ?col))
            (not(is-locked ?cor))
            ; when uses2 becomes uses1 and when uses1 becomes uses0
            (when (and (uses2 ?k)) (and (not(uses2 ?k)) (uses1 ?k)))
            (when (and (uses1 ?k)) (and (not(uses1 ?k)) (uses0 ?k)))
        )
    )

    ;Hero can clean a location if
    ;    - the hero is at location ?loc,
    ;    - the location is messy
    ;Effect will be that the location is no longer messy
    (:action clean

        :parameters (?loc - location)

        :precondition (and
            ; Change predicates associated with messy room if hero is in right spot
            (hero-at ?loc)
            (messy ?loc)

        )

        :effect (and
            (not(messy ?loc))

        )
    )

)