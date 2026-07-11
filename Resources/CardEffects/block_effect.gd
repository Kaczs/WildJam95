class_name BlockEffect
extends CardEffect
@export var damage_amount:int

func doEffect(context:CombatContext):
	context.give_block(context.target, damage_amount)
