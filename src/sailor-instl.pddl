;author David Omrai

(define 
    (problem problem_name) 
    (:domain sailor_domain)
    (:requirements :strips :typing :disjunctive-preconditions :equality :conditional-effects :negative-preconditions)
    (:objects 
            
            ;forest river town academy lighthouse sea insland harbor pub - place
            ;;dinghy frigate caravel - ship
            ;alcohol pearl flowers treasure_map bear_skin cocos cocaine wood gold_grain gold_coin gold_brick criminal_record - item
            ;;drunk in_mood addicted strengthened - mood
            ;married  pirate captain - ranks
            ;good_acquaintences doubtful_acquaintences - contacts
            ;fought_bear defeated_pirates - achievements
            sailor - person    

    )

    (:init
        ;where is and is not sailor
        (at sailor harbor)
        (not(at sailor river))
        (not(at sailor forest))
        (not(at sailor academy))
        (not(at sailor sea))
        (not(at sailor lighthouse))
        (not(at sailor island))
        (not(at sailor pub))
        (not(at sailor town))
        ;have ships
        (not(have sailor dinghy))
        (not(have sailor frigate))
        (not(have sailor caravel))
        ;material
        (not(have sailor alcohol))
        (not(have sailor pearl))
        (not(have sailor flowers))
        (not(have sailor treasure_map))
        (not(have sailor bear_skin))
        (not(have sailor coconuts))
        (not(have sailor cocaine))
        (not(have sailor wood))
        (not(have sailor gold_grain))
        (not(have sailor gold_coin))
        (not(have sailor gold_brick))
        (not(have sailor criminal_record))
        ;contacts
        (not(have sailor good_acquaintences))
        (not(have sailor doubtful_acquaintences))
        (not(have sailor smugglers_acquaintences))
        ;achievements
        (not(have sailor fought_bear))
        (not(have sailor defeated_pirates))
        ;moods
        (not(is sailor in_mood))
        (not(is sailor drunk))
        (not(is sailor addicted))
        (not(is sailor strengthened))
        ;ranks
        (not(is sailor married))
        (not(is sailor pirate))
        (not(is sailor captain))
        ;todo: put the initial state's facts and numeric values here
    )

    (:goal (or
                ;marriage
                (and 
                    (at sailor island)
                    (have sailor gold_brick)
                    (have sailor pearl)
                    (have sailor flowers)
                    (is sailor married)
                    (have sailor good_acquaintences)
                    ;(not(is sailor in_mood))
                    (not(is sailor drunk))
                    (not(is sailor addicted))
                    (not(have sailor criminal_record))
                )
                ;admiral
                (and
                    (at sailor academy)
                    (is sailor captain)
                    (have sailor defeated_pirates)
                    (not(have sailor criminal_record))
                    (not(is sailor drunk))
                    (not(is sailor in_mood))
                )
                ;happy end
                (and
                    (is sailor addicted)
                    (have sailor cocaine)
                    (have sailor frigate)
                    (have sailor gold_brick)
                    (have sailor smugglers_acquaintences)
                )
            )
    )
)
