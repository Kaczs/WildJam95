class_name BlockEffect
extends CardEffect
@export var block_amount:int

func doEffect(context:CombatContext):
	context.give_block(context.target, block_amount)
