class_name CombatContext
extends Resource

var combatResolver
var target:Combatant
var was_planted:bool
var turn:int = 0

func _init(target:Combatant, turn:int, was_planted:bool = false ) -> void:
	pass