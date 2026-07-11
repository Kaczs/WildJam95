## This script will just be for handling the control parts of the card
## such as left clicking it. CardData will hold the effects.
class_name Card extends Control

@export var data:CardData
var test_enemy

func _ready() -> void:
	var name_text:RichTextLabel = get_node_or_null("Name")
	if name_text == null:
		push_error("Card without a name Rich Text Label")
		return
	name_text.text = data.card_name
	test_enemy = get_tree().get_first_node_in_group("test_badguy") as Combatant
	
func _on_button_pressed() -> void:
	CombatManager.play_card(data, test_enemy)
	self.queue_free()
