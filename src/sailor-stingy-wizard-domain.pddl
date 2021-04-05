;author David Omrai
;Header and description

(define (domain sailor_domain)

;remove requirements that are not needed
(:requirements :strips :typing :disjunctive-preconditions :equality :conditional-effects :negative-preconditions)

(:types 
        place;forest river town academy lighthouse sea island harbor pub - place
        ship;dinghy frigate caravel - ship
        item;;alcohol pearl flowers treasure_map bear_skin coconuts cocaine wood gold_grain gold_coin gold_brick criminal_record - item
        mood;drunk in_mood addicted strengthened - mood
        ranks;married  pirate captain - ranks
        contacts;good_acquaintences doubtful_acquaintences - contacts
        achievements;fought_bear defeated_pirates - achievements
        person;sailor - person
)

(:constants 
    forest river town academy lighthouse sea island harbor pub - place
    dinghy frigate caravel - ship
    alcohol pearl flowers treasure_map bear_skin coconuts cocaine wood gold_grain gold_coin gold_brick criminal_record - item
    drunk in_mood addicted strengthened - mood
    married  pirate captain - ranks
    good_acquaintences doubtful_acquaintences smugglers_acquaintences - contacts
    fought_bear defeated_pirates - achievements
)

; un-comment following line if constants are needed
;(:constants )

(:predicates    (at ?who - person ?x - place)  ;at place
                ;(own ?who - person ?x) ;own a ship
                (have ?who - person ?x);has item, achievement or contact
                (is ?who - person ?x)  ;is in some mood or has rank
)


;(:functions ;todo: define numeric functions here
;)


;one neighbor
(:action go_to_pub
    :parameters     (?who - person)
    :precondition   (or
                        (at ?who harbor)
                    )
    :effect         (and
                        (at ?who pub)
                        (not(at ?who harbor))
                    )
)

(:action go_to_island
    :parameters     (?who - person)
    :precondition   (and 
                        (at ?who sea)
                        (or
                            (have ?who dinghy)
                            (have ?who caravel)
                            (have ?who frigate)
                        )
                    )
    :effect         (and
                        (at ?who island)
                        (not(at ?who sea))
                    )
)

(:action go_to_academy
    :parameters     (?who - person)
    :precondition   (or
                        (at ?who town)
                    )
    :effect         (and
                        (at ?who academy)
                        (not(at ?who town))
                    )
)

(:action go_to_forest
    :parameters     (?who - person)
    :precondition   (or
                        (at ?who river)
                    )
    :effect         (and
                        (at ?who forest)
                        (not(at ?who river))
                    )
)
;more than one neighbor
(:action go_to_river
    :parameters     (?who - person)
    :precondition   (or
                        (at ?who forest)
                        (at ?who harbor)
                    )
    :effect         (and
                        (at ?who river)
                        (not(at ?who harbor))
                        (not(at ?who forest))
                    )
)

(:action go_to_town
    :parameters     (?who - person)
    :precondition   (or
                        (at ?who harbor)
                        (at ?who academy)
                    )
    :effect         (and
                        (at ?who town)
                        (not(at ?who harbor))
                        (not(at ?who academy))
                    )
)

(:action go_to_lighthouse
    :parameters     (?who - person)
    :precondition   (and   
                        (or
                            (at ?who harbor)
                            (at ?who sea)
                        )
                        (or
                            (have ?who dinghy)
                            (have ?who caravel)
                            (have ?who frigate)
                        )
                    )
    :effect         (and
                        (at ?who lighthouse)
                        (not(at ?who harbor))
                        (not(at ?who sea))
                    )
)

(:action go_to_harbor
    :parameters     (?who - person)
    :precondition   (or
                        (at ?who pub)
                        (at ?who river)
                        (at ?who town)
                        (and
                            (or
                                (at ?who sea)
                                (at ?who lighthouse)
                            )
                            (or
                                (have ?who dinghy)
                                (have ?who caravel)
                                (have ?who frigate)
                            )
                        )
                    )
    :effect         (and
                        (at ?who harbor)
                        (not(at ?who pub))
                        (not(at ?who sea))
                        (not(at ?who river))
                        (not(at ?who lighthouse))
                        (not(at ?who town))
                    )
)


;crafting----------------------------------------------------------
(:action build_dinghy
    :parameters     ( ?who - person )
    :precondition   (and
                        (have ?who wood)
                        (not(have ?who dinghy))
                    )
    :effect         (and
                        (have ?who dinghy)
                        (not(have ?who wood))
                    )
)

(:action build_frigate
    :parameters     ( ?who - person)
    :precondition   (and 
                        (have ?who dinghy)
                        (have ?who wood)
                        (have ?who gold_grain)
                    )
    :effect         (and
                        (have ?who frigate)
                        (not(have ?who wood))
                        (not(have ?who dinghy))
                        (not(have ?who gold_grain))
                    )
)

(:action build_caravel
    :parameters     ( ?who - person)
    :precondition   (and 
                            (have ?who dinghy)
                            (have ?who wood)
                            (have ?who gold_coin)
                    )
    :effect         (and
                        (have ?who caravel)
                        (not(have ?who wood))
                        (not(have ?who dinghy))
                        (not(have ?who gold_coin))
                    )
)


;mood--------------------------------------------------------------
(:action get_in_mood
    :parameters     (?who - person)
    :precondition   ( and 
                        (have ?who alcohol)
                        (not(is ?who in_mood))
                        (not(is ?who drunk))
                    )
    :effect         (and 
                        (is ?who in_mood)
                        (not (have ?who alcohol))
                    )
)

(:action get_drunk
    :parameters     (?who - person)
    :precondition   (and 
                        (have ?who alcohol)
                        (is ?who in_mood)
                        (not(is ?who drunk))
                    )
    :effect         (and 
                        (is ?who drunk)
                        (not (is ?who in_mood))
                        (not (have ?who alcohol))
                    )
)

(:action get_addicted
    :parameters     (?who - person)
    :precondition   (and
                        (have ?who alcohol)
                        (not (is ?who in_mood))
                        (is ?who drunk)
                    )
    :effect         (and 
                        (is ?who addicted)
                        (not (have ?who alcohol))
                    )
)


;forest------------------------------------------------------------
(:action chop_tree
    :parameters     ( ?who - person )
    :precondition   (or
                        (at ?who forest)
                        (at ?who island)
                    )
    :effect         (have ?who wood)
)

(:action collect_flowers
    :parameters     ( ?who - person)
    :precondition   (and 
                        (at ?who forest)
                    )
    :effect         (have ?who flowers)
)


(:action fight_with_bear
    :parameters     ( ?who - person )
    :precondition   (and
                        (at ?who forest)
                    )
    :effect         (and
                        (have ?who fought_bear)
                        (have ?who bear_skin)
                        (is ?who strengthened)
                    )
)

(:action meet_wizard
    :parameters     ( ?who - person )
    :precondition   (and
                        (at ?who forest)
                        (have ?who alcohol)
                    )
    :effect         (and
                        (not(have ?who alcohol))
                        (have ?who doubtful_acquaintences)
                    )
)


;river-------------------------------------------------------------
(:action steal_dinghy
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who river)
                        (not(have ?who dinghy))
                    )
    :effect         (and
                        (have ?who dinghy)
                        (have ?who criminal_record)
                    )
)

(:action gold_grinding
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who river)
                        (not(have ?who gold_grain))
                    )
    :effect         (and
                        (have ?who gold_grain)
                    )
)

(:action cold_swim
    :parameters     ( ?who - person)
    :precondition   (and
                        (or
                            (at ?who river)
                            (at ?who sea)
                        )
                        (or
                            (is ?who drunk)
                            (is ?who in_mood)
                        )
                    )
    :effect         (and
                        (not(is ?who in_mood))
                        (not(is ?who drunk))
                    )
)


;harbor------------------------------------------------------------
(:action work
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who harbor)
                    )
    :effect         (and
                        (have ?who gold_grain)
                    )
)

(:action trade
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who harbor)
                        (have ?who coconuts)
                        (have ?who bear_skin)
                    )
    :effect         (and
                        (not(have ?who coconuts))
                        (not(have ?who bear_skin))
                        (have ?who gold_coin)
                    )
)

(:action meet_smugglers
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who harbor)
                        (have ?who doubtful_acquaintences)
                        (have ?who gold_brick)
                    )
    :effect         (and
                        (have ?who smugglers_acquaintences)
                    )
)


;pub---------------------------------------------------------------
(:action buy_ale
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who pub)
                        (have ?who gold_grain)
                    )
    :effect         (and
                        (have ?who alcohol)
                        (not(have ?who gold_grain))
                    )
)

(:action pay_for_ale
    :parameters     ( ?who - person )
    :precondition   (and
                        (at ?who pub)
                        (have ?who gold_coin)
                    )
    :effect         (and
                        (not(have ?who gold_coin))
                        (have ?who good_acquaintences)
                    )
)

(:action pub_fight
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who pub)
                        (is ?who in_mood)
                    )
    :effect         (and
                        (is ?who strengthened)
                    )
)


;town--------------------------------------------------------------
(:action deposit
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who town)
                        (have ?who gold_grain)
                    )
    :effect         (and
                        (have ?who gold_coin)
                        (have ?who good_acquaintences)
                        (not(have ?who gold_grain))
                    )
)

(:action invest
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who town)
                        (have ?who gold_coin)
                    )
    :effect         (and
                        (have ?who gold_brick)
                        (have ?who good_acquaintences)
                        (not(have ?who gold_coin))
                    )
)

(:action steal_coin
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who town)
                    )
    :effect         (and
                        (have ?who gold_coin)
                        (have ?who criminal_record)
                    )
)

(:action clear_name
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who town)
                        (have ?who criminal_record)
                        (have ?who gold_grain)
                    )
    :effect         (and
                        (not(have ?who criminal_record))
                        (not(have ?who gold_grain))
                    )
)

(:action public_work
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who town)
                        (have ?who criminal_record)
                    )
    :effect         (and
                        (not(have ?who criminal_record))
                        (is ?who in_mood)
                    )
)


;academy-----------------------------------------------------------
(:action graduate_academy
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who academy)
                        (have ?who gold_coin)
                        (not (have ?who criminal_record))
                    )
    :effect         (and
                        (is ?who captain)
                    )
)


;sea---------------------------------------------------------------
(:action go_to_sea
    :parameters     (?who - person)
    :precondition   (and
                        (or
                            (at ?who harbor)
                            (at ?who island)
                            (at ?who lighthouse)
                        )
                        (or
                            (have ?who dinghy)
                            (have ?who caravel)
                            (have ?who frigate)
                        )
                    )     
    :effect         (and 
                        (when 
                            ;when
                            (not (is ?who strengthened))
                            ;then
                            (and
                                (not(have ?who gold_grain))
                                (not(have ?who gold_coin))
                                (not(have ?who gold_brick))
                                (not(have ?who frigate))
                                (not(have ?who caravel))
                                (is ?who strengthened)
                                (have ?who dinghy)
                            )
                        )
                        (at ?who sea)
                        (not(at ?who harbor))
                        (not(at ?who island))
                        (not(at ?who lighthouse))
                    )
)

(:action join_pirates
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who sea)
                        (have ?who doubtful_acquaintences)
                    )
    :effect         (and
                        (is ?who pirate)
                        (is ?who in_mood)
                    )
)

(:action defeat_pirates
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who sea)
                        (is ?who strengthened)
                        (have ?who caravel)
                    )
    :effect         (and
                        (have ?who defeated_pirates)
                        (have ?who gold_grain)
                        (have ?who gold_coin)
                        (have ?who gold_brick)
                        (have ?who frigate)
                        (have ?who caravel)
                        (have ?who dinghy)
                    )
)

(:action hunt_pearl
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who sea)
                    )
    :effect         (and
                        (have ?who pearl)
                    )
)

;lighthouse--------------------------------------------------------
(:action propose
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who lighthouse)
                        (or
                            (have ?who fought_bear)
                            (have ?who defeated_pirates)
                            (is ?who captain)
                        )                        
                    )
    :effect         (and
                        (is ?who married)
                    )
)

;island------------------------------------------------------------
(:action collect_coconuts
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who island)
                    )
    :effect         (and
                        (have ?who coconuts)
                    )
)

(:action find_cocaine
    :parameters     ( ?who - person)
    :precondition   (and
                        (at ?who island)
                        (have ?who treasure_map)
                    )
    :effect         (and
                        (have ?who cocaine)
                    )
)

;end
)
