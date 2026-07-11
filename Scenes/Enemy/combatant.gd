class_name Combatant 
extends Control

@export var max_health:int = 100
## If we want to "plant" a card targetting this enemy the next time we're here
## we can't just reference the node since it'll get freed. Just increment by one
## for each enemy.
@export var spawn_slot = 0

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
	CombatManager.play_card(data,self)
	AudioManager.play_global("SFX",AudioManager.HIT,-12)
