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
        (is-corr ?loc - location ?cor - corridor ?loc - location )
        (is-locked ?cor - corridor)
        (risky ?cor - corridor)
        (collapsed ?cor - corridor)
        (messy ?loc - location)
        (key-at ?loc -location ?key -key)
        ; (holding ?key -key) ; maybe set this as false to start
        (is-locked-col ?cor - corridor ?col - colour)
        (uses ?key -key)
        (uses0 ?key - key)
        (uses1 ?key - key)
        (uses2 ?key - key)
        (key-col ?key - key ?col - colour)
        (key-usage ?key - key )
        (no-key ?key - key)

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

            (hero-at ?from)   
            (is-corr ?from ?cor ?to)   
            (not (is-locked ?cor))     
            (not (collapsed ?cor))               

        )

        :effect (and
            (hero-at ?to)
            (when (and (risky ?cor)) (and (messy ?to) (collapsed ?cor)))
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
        (hero-at ?loc)
        (key-at ?loc ?k)
        (no-key ?k)
        ; (not(holding ?k)) ; fix this
        (not(messy ?loc))           

        )

        :effect (and
            (not(no-key ?k))
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

            (not(no-key ?k))
            (hero-at ?loc)

        )

        :effect (and

            (no-key ?k)
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
            (hero-at ?loc) 
            (not(no-key ?k))
            (not(uses0 ?k))                       
            (is-locked ?cor)
            (is-locked-col ?cor ?col)
            (is-corr ?loc ?cor ?loc )
            (key-col ?k ?col)

        )

        :effect (and
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

            (hero-at ?loc)
            (messy ?loc)

        )

        :effect (and

            (not(messy ?loc))

        )
    )

)

