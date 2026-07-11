class_name Combatant 
extends Control

@export var max_health:int = 100
var current_health:int
var block:int # The amount of damage to be blocked


func _ready() -> void:
	current_health = max_health


func take_damage(amount:int):
	current_health -= amount
	if current_health <= 0:
		#die
		self.queue_free()


func gain_block(amount:int):
	block += amount


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is CardData:
		return true
	else:	
		return false


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if data.is_plant_mode:
		CombatManager.plant_card(data, CombatManager.current_stage, CombatManager.current_turn, self.name)
		AudioManager.play_global("WELD",AudioManager.HIT,-12)
	else:
		CombatManager.play_card(data,self)
		AudioManager.play_global("SFX",AudioManager.HIT,-12)
