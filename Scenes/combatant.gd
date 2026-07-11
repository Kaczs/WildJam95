class_name Combatant 
extends Node

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
