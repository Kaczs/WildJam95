## In the context of the command pattern this is our "actor".
## Combat Manager will build one per card.
## add methods here as we need more mechanics
## ie. deal damage, apply status, block, etc.
class_name CombatContext
extends Resource

var target:Combatant
var was_planted:bool
var turn:int = 0

# Will need for setting up cards in the past
func _init(given_target:Combatant, given_turn:int, given_was_planted:bool = false ) -> void:
	target = given_target
	turn = given_turn
	was_planted = given_was_planted

func deal_damage(given_target:Combatant, amount:int):
	if given_target == null or given_target.current_health <= 0:
		return # Dead or doesnt exist
	given_target.take_damage(amount)