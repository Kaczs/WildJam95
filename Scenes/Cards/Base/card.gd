## This script will just be for handling the control parts of the card
## such as left clicking it. CardData will hold the effects.
class_name Card extends Control

@export var data:CardData
var test_enemy
var is_on_cooldown:bool

func _ready() -> void:
	var name_text:RichTextLabel = get_node_or_null("Name")
	if name_text == null:
		push_error("Card without a name Rich Text Label")
		return
	name_text.text = data.card_name
	test_enemy = get_tree().get_first_node_in_group("test_badguy") as Combatant


func _on_button_pressed() -> void:
	print("Right mouse pressed")
	# Eventually players should be able to plant in previous turns but that'll need some UI
	# for now this just does the current one.
	CombatManager.plant_card(data, CombatManager.current_stage, CombatManager.current_turn, self.name)
	self.queue_free()


func _get_drag_data(_at_position: Vector2) -> Variant:
	#returning null means you can no longer drag the card
	if is_on_cooldown:
		return null
	
	#ordering matters here if we set_modulate before set_drag_preview then the drag preview will be greyed out
	set_drag_preview(self.duplicate())
	self.set_modulate(Color.DARK_GRAY)
	AudioManager.play_global("SFX",AudioManager.SELECT_CARD)
	
	return data


func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		self.set_modulate(Color.WHITE)
		if is_drag_successful():
			pass
