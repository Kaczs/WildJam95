class_name DamageEffect
extends CardEffect
@export var damage_amount:int

func doEffect(context:CombatContext):
	context.deal_damage(context.target, damage_amount)
